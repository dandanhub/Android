package cmu.edu.hw2dandans;

/**
 * Created by dandanshi on 6/3/17.
 */

public class Event {
    private long id;
    private String name;
    private String dateTime;
    private String location;

    private static long counter = 0;

    public Event(){
    }

    public Event(String name, String dateTime, String location){
        this.id = counter++;
        this.name = name;
        this.dateTime = dateTime;
        this.location = location;
    }

//    public void setId(long id) {
//        this.id = id;
//    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDateTime() {
        return dateTime;
    }

    public String getLocation() {
        return location;
    }

}
