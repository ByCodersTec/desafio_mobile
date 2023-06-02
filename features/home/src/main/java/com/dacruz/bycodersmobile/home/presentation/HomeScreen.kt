package com.dacruz.bycodersmobile.home.presentation

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.AlertDialog
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalLifecycleOwner
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.app.ActivityCompat
import androidx.lifecycle.Lifecycle.Event.ON_CREATE
import androidx.lifecycle.Lifecycle.Event.ON_DESTROY
import androidx.lifecycle.Lifecycle.Event.ON_PAUSE
import androidx.lifecycle.Lifecycle.Event.ON_RESUME
import androidx.lifecycle.Lifecycle.Event.ON_START
import androidx.lifecycle.Lifecycle.Event.ON_STOP
import androidx.lifecycle.LifecycleEventObserver
import com.dacruz.bycodersmobile.home.R
import com.dacruz.bycodersmobile.home.presentation.HomeState.DisplayMap
import com.dacruz.bycodersmobile.home.presentation.HomeState.Empty
import com.dacruz.bycodersmobile.home.presentation.HomeState.Error
import com.dacruz.bycodersmobile.home.presentation.HomeState.Loading
import com.dacruz.navigator.NavigationHandler
import com.dacruz.navigator.Screen
import com.dacruz.navigator.collectAsType
import com.dacruz.theme.components.DefaultToolbar
import com.dacruz.theme.components.WithErrorHandling
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.PermissionStatus
import com.google.accompanist.permissions.rememberPermissionState
import com.google.accompanist.permissions.shouldShowRationale
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.MapView
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.model.MarkerOptions
import org.koin.androidx.compose.getViewModel

@Composable
fun HomeScreen(navigationHandler: NavigationHandler) {
    val homeViewModel: HomeViewModel = getViewModel()

    val mapState by homeViewModel.mapState.collectAsState()
    val email = navigationHandler.transportedData.collectAsType<String>() ?: ""

    LaunchedEffect(key1 = Unit) {
        homeViewModel.getUserLocalization(email)
    }

    Scaffold(
        topBar = {
            DefaultToolbar(
                title = "Home Screen",
                onUpPress = {
                    navigationHandler.navigateTo(Screen.LoginScreen, pop = Screen.HomeScreen)
                }
            )
        },
        content = {
            it
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center,
            ) {
                when (mapState) {
                    is Loading -> {
                        CircularProgressIndicator()
                    }

                    is Error -> {
                        WithErrorHandling(
                            errorMessage = (mapState as Error).error.localizedMessage,
                            retryAction = { homeViewModel.clearComposable() }
                        )
                    }

                    is DisplayMap -> {
                        MapScreen(email, homeViewModel, navigationHandler)
                    }

                    is Empty -> {
                        MapScreen(email, homeViewModel, navigationHandler)
                    }
                }
            }
        }
    )
}

@OptIn(ExperimentalPermissionsApi::class)
@Composable
fun MapScreen(
    email: String,
    homeViewModel: HomeViewModel,
    navigationHandler: NavigationHandler,
) {
    val context = LocalContext.current
    val mapView = rememberMapViewWithLifecycle()
    val permissionState = rememberPermissionState(Manifest.permission.ACCESS_FINE_LOCATION)
    val showDialog = remember { mutableStateOf(false) }

    LaunchedEffect(permissionState) {
        if (permissionState.status.shouldShowRationale) {
            showDialog.value = true
        } else {
            permissionState.launchPermissionRequest()
        }
    }

    when (permissionState.status) {
        is PermissionStatus.Granted -> {
            showDialog.value = false
            AndroidView({ mapView }) {
                setUpMap(it, homeViewModel, email, context)
            }
        }

        is PermissionStatus.Denied -> {
            showDialog.value = true
        }

        else -> Unit
    }

    if (showDialog.value) {
        showPermissionNeededDialog(onOkClick = {
            navigationHandler.navigateTo(Screen.LoginScreen)
        })
    }
}


@Composable
fun showPermissionNeededDialog(onOkClick: () -> Unit) {
    AlertDialog(
        onDismissRequest = onOkClick,
        title = { Text(stringResource(id = R.string.location_permission_needed)) },
        text = { Text(stringResource(id = R.string.location_permission_needed_message)) },
        confirmButton = {
            TextButton(onClick = onOkClick) {
                Text(stringResource(id = R.string.ok))
            }
        }
    )
}

fun setUpMap(
    mapView: MapView,
    viewModel: HomeViewModel,
    userEmail: String,
    appContext: Context
) {

    val locationProvider: FusedLocationProviderClient by lazy {
        LocationServices.getFusedLocationProviderClient(appContext)
    }

    var currentMarker: Marker? = null

    mapView.getMapAsync { map ->
        val permissions = arrayOf(
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION
        )

        if (permissions.any {
                ActivityCompat.checkSelfPermission(
                    appContext,
                    it
                ) != PackageManager.PERMISSION_GRANTED
            }) {
            return@getMapAsync
        }

        map.run {
            isMyLocationEnabled = true
            setMaxZoomPreference(10f)
            uiSettings.apply {
                isCompassEnabled = true
                isMapToolbarEnabled = true
                isMyLocationButtonEnabled = true
                isZoomControlsEnabled = true
                isRotateGesturesEnabled = true
                isTiltGesturesEnabled = true
            }

            viewModel.userLocalization.value?.let {
                LatLng(it.latitude, it.longitude)
            }?.also { latLng ->
                currentMarker = addMarker(MarkerOptions().position(latLng))
                moveCamera(CameraUpdateFactory.newLatLngZoom(latLng, 6f))
            } ?: locationProvider.lastLocation
                .addOnSuccessListener { location ->
                    location?.let {
                        val currentPosition = LatLng(it.latitude, it.longitude)
                        clear()
                        currentMarker = addMarker(MarkerOptions().position(currentPosition))
                        moveCamera(CameraUpdateFactory.newLatLngZoom(currentPosition, 6f))
                    }
                }
                .addOnFailureListener(viewModel::setError)

            setOnMapClickListener { newLatLng ->
                currentMarker?.remove()
                currentMarker = addMarker(MarkerOptions().position(newLatLng))

                viewModel.insertOrUpdateUserLocalization(
                    userEmail,
                    newLatLng.latitude,
                    newLatLng.longitude
                )
            }
        }
    }
}

@Composable
fun rememberMapViewWithLifecycle(): MapView {
    val context = LocalContext.current
    val mapView = remember { MapView(context) }
    val lifecycle = LocalLifecycleOwner.current.lifecycle


    DisposableEffect(lifecycle) {
        val lifecycleObserver = LifecycleEventObserver { _, event ->
            when (event) {
                ON_CREATE -> mapView.onCreate(Bundle())
                ON_START -> mapView.onStart()
                ON_RESUME -> mapView.onResume()
                ON_PAUSE -> mapView.onPause()
                ON_STOP -> mapView.onStop()
                ON_DESTROY -> mapView.onDestroy()
                else -> throw IllegalStateException()
            }
        }
        lifecycle.addObserver(lifecycleObserver)
        onDispose {
            lifecycle.removeObserver(lifecycleObserver)
        }
    }
    return mapView
}
