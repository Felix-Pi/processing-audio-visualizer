void setProgress(int current, int max, String songName) {
    //loading screen
    loading_amount.setText(current + "/" + max);
    loading_file.setText(songName);
    loading_slider.setValue(current);
}
