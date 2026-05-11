package com.gigfinance.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.gigfinance.app.ui.navigation.GigFinanceNavHost
import com.gigfinance.app.ui.theme.GigFinanceTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            GigFinanceTheme {
                Surface(modifier = Modifier) {
                    GigFinanceNavHost()
                }
            }
        }
    }
}
