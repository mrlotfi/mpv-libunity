#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include <QtDBus>

#include <mpv/client.h>

void set_progress(double pos, double len)
{
    QDBusMessage signal = QDBusMessage::createSignal(
        "/",
        "com.canonical.Unity.LauncherEntry",
        "Update");
    signal << "application://mpv.desktop";
    QVariantMap setProperty;

    setProperty.insert("count", qint64(1));
    setProperty.insert("count-visible", true);
    setProperty.insert("progress", double(pos / len));
    setProperty.insert("progress-visible", true);

    signal << setProperty;
    QDBusConnection::sessionBus().send(signal);
}

extern "C"
{

    int mpv_open_cplugin(mpv_handle *handle)
    {
        double len;
        double pos;
        while (1)
        {
            mpv_event *event = mpv_wait_event(handle, 1);
            mpv_get_property(handle, "time-pos", MPV_FORMAT_DOUBLE, &pos);
            mpv_get_property(handle, "duration", MPV_FORMAT_DOUBLE, &len);
            printf("Got event: %d %f\n", event->event_id, len);
            set_progress(pos, len);
            if (event->event_id == MPV_EVENT_SHUTDOWN)
                break;
        }
        return 0;
    }

}
