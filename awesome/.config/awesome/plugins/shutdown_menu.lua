return {
    { "No ", "" },
    { "Suspend", "" },
    { "Reboot", "doas shutdown -r now" },
    { "Yes", "doas shutdown -p now" }
}
