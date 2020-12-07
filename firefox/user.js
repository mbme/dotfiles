// for 60hz monitor
user_pref("layout.frame_rate", -1);

// for 144hz monitor
// user_pref("layout.frame_rate", 144);

// do not detach tabs with drag-n-drop
user_pref("browser.tabs.allowTabDetach", false);

// Hide title bar and window border
user_pref("browser.tabs.drawInTitlebar", true);

// https://wiki.archlinux.org/index.php/Firefox#Hardware_video_acceleration
user_pref("media.av1.enabled", false); // youtube crashes as of FF82
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffvpx.enabled", false);

// https://wiki.archlinux.org/index.php/Firefox#Right_mouse_button_instantly_clicks_the_first_option_in_window_managers
user_pref("ui.context_menus.after_mouseup", true);

// disable Pocket
user_pref("extensions.pocket.enabled", false);

// better privacy
user_pref("privacy.trackingprotection.enabled", true);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("toolkit.telemetry.enabled", false);
user_pref("privacy.donottrackheader.enabled", true);
user_pref("geo.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);


