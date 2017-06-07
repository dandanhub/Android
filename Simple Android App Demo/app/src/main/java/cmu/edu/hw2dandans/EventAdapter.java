package cmu.edu.hw2dandans;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by dandanshi on 6/3/17.
 */

public class EventAdapter extends ArrayAdapter<Event> {

    public EventAdapter(Context context, int textViewResourceId, ArrayList<Event> items) {
        super(context, textViewResourceId, items);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        // Get the data item for this position
        Event event = getItem(position);
        // Check if an existing view is being reused, otherwise inflate the view
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.item_event, parent, false);
        }
        // Lookup view for data population
        TextView eventName = (TextView) convertView.findViewById(R.id.eventName);
        TextView eventDateTime = (TextView) convertView.findViewById(R.id.eventDateTime);
        TextView eventLocation = (TextView) convertView.findViewById(R.id.eventLocation);
        // Populate the data into the template view using the data object
        eventName.setText(event.getName());
        eventDateTime.setText(event.getDateTime());
        eventLocation.setText(event.getLocation());
        // Return the completed view to render on screen
        return convertView;
    }
}