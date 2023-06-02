package com.dacruz.bycodersmobile.navigator

import com.dacruz.navigator.Navigator
import com.dacruz.navigator.Screen
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.test.runTest
import org.junit.Assert.*
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@RunWith(JUnit4::class)
class NavigatorTest {

    private val navigator = Navigator()

    @OptIn(ExperimentalCoroutinesApi::class)
    @get:Rule
    var coroutinesTestRule = CoroutineTestRule()

    @Test
    fun `when navigateTo is called, it should update currentScreen`() = runTest {
        navigator.navigateTo(Screen.HomeScreen)

        assertEquals(Screen.HomeScreen, navigator.currentScreen.first())
    }

    @Test
    fun `when navigateBack is called, it should update currentScreen to previous screen`() = runTest {
        navigator.navigateTo(Screen.HomeScreen)
        navigator.navigateTo(Screen.LoginScreen)

        navigator.navigateBack()

        assertEquals(Screen.HomeScreen, navigator.currentScreen.first())
    }

    @Test
    fun `when navigateTo is called with extra, it should update transportedData`() = runTest {
        val extraData = "Extra Data"
        navigator.navigateTo(Screen.HomeScreen, extra = extraData)

        assertEquals(extraData, navigator.transportedData.first())
    }

    @Test
    fun `when navigateBack is called and only one screen in history, it should call onAppExit`() = runTest {
        var exitCalled = false

        navigator.navigateBack { exitCalled = true }

        assertTrue(exitCalled)
    }

}
