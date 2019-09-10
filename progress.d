module progress;

import std.stdio;
import std.conv;
import std.string;
import std.process;
import core.stdc.stdlib : exit;
import core.sys.posix.sys.ioctl;

class Progress {
	int spaces;
	float step;
	string line = "\033[47;30m[\033[00m#\033[47;30m]\033[00m ($%)";
	winsize w;
	string progressColor;
	string keywordColor = "\033[38;5;154m";
    string progressText;

	this(string text = "Progress... ") {		
		ioctl(1, TIOCGWINSZ, &w);
		if (w.ws_col < 30) {
			exit(-1);
		} else {
			if (w.ws_col < 40) {
				spaces = 10;
			} else if (w.ws_col <= 50) {
				spaces = 20;
			} else if (w.ws_col <= 60) {
				spaces = 30;
			} else if (w.ws_col < 80) {
				spaces = 40;
			} else if (w.ws_col >= 80) {
				spaces = 50;
			}
		}
		
		step = 100/spaces;
		
		auto colorSupport = executeShell("tput colors");
		int colors = to!int(colorSupport.output.chop());
		if (colors == 256) progressColor = "\033[48;5;202m";
		else {
			progressColor = "\033[41m";
			keywordColor = "";
		}
        
        this.progressText = text;
	}

	public void displayProgress(float percent) {		
		int colored = to!int(percent/step);
		string coloredSpaces = progressColor;
		foreach (int i; 0..colored) {
			coloredSpaces ~= " ";
		}
		coloredSpaces ~= "\033[00m";
		if (colored < spaces) {
			foreach (int i; 0..(spaces-colored)) {
				coloredSpaces ~= " ";
			}
		}
		float percent2 = to!int(percent / 0.5);
		percent2 = percent2 * 0.5;
		
		string percentText = text(percent2);
		if (percentText.length < 4) {
			for (int i = 0; i <= 4 - percentText.length; i++) {
				percentText = " " ~ percentText;
			}
		}
		
		string resultingLine = line.replace("#", coloredSpaces).replace("$", percentText);
		write(progressText ~ resultingLine ~ "\r");
	}
}
