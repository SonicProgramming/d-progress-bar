module example;

import std.stdio;
import core.time : dur;
import core.thread : Thread;
import progress;

void main(string[] args) {
    Progress prog = new Progress("Example ");
    for (float f = 0f; f <= 100f; f += 0.5) {
        prog.displayProgress(f);
        Thread.sleep(dur!"msecs"(25));
    }
    writeln();
}
