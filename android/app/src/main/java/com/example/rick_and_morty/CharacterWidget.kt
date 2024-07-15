package com.example.rick_and_morty

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import java.io.File

/**
 * Implementation of App Widget functionality.
 */
class CharacterWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    val views = RemoteViews(context.packageName, R.layout.character_widget)

    // Construct the RemoteViews object
    val data = HomeWidgetPlugin.getData(context);

    val characterId = data.getInt("id", 1)

    val name = data.getString("name", "Rick Sanchez")
    views.setTextViewText(R.id.character_name_text, name)

    val imagePath = data.getString("image", "") ?: ""
    val imageFile = File(imagePath)
    val imageExists = imageFile.exists()
    if (imageExists) {
        val image: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
        views.setImageViewBitmap(R.id.widget_image, image)
    }
    val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
        context,
        MainActivity::class.java,
        Uri.parse("homeWidgetExample://com.rickandmorty.com/?characterId=$characterId"))

    views.setOnClickPendingIntent(R.id.character_widget_container, pendingIntentWithData)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}