package com.gigfinance.app.data.local

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.gigfinance.app.domain.model.TransactionType

@Entity(tableName = "transactions")
data class TransactionEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val title: String,
    val amount: Double,
    val type: TransactionType,
    val timestamp: Long = System.currentTimeMillis()
)
