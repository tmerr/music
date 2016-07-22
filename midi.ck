MidiIn min1;
MidiIn min2;
MidiMsg msg;

// open midi receiver, exit on fail
if ( !min1.open(0) ) me.exit(); 
if ( !min2.open(1) ) me.exit(); 

fun void keyboardLoop() {
    while (true) {
        min1 => now; // wait on midi event

        while(min1.recv(msg)) {
            <<< msg.data1, msg.data2, msg.data3 >>>;
            playKeyboard(msg.data2, msg.data3);
        }
    }
}

fun void playKeyboard(int key, int velocity) {
    Std.mtof(key) => float freq;
    velocity / 128.0 => float vel;
}

fun void knobLoop() {
    while (true) {
        min2 => now;
        
        while (min2.recv(msg)) {
            <<< msg.data1, msg.data2, msg.data3 >>>;
        }
    }
}

spork ~ keyboardLoop();
knobLoop();