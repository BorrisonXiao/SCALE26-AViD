% Generated categorical evidence and explicit supported/refuted/unknown composition.
7.8889034817906428e-06::status(o_059efb40dc6588f5a7c3,supported); 4.539750508706336e-05::status(o_059efb40dc6588f5a7c3,refuted); 0.99994671359143117::status(o_059efb40dc6588f5a7c3,unknown).
0::status(o_12708a8a192009601d34,supported); 0::status(o_12708a8a192009601d34,refuted); 1::status(o_12708a8a192009601d34,unknown).
0::status(o_1cdbf820ca243bd3fb99,supported); 0::status(o_1cdbf820ca243bd3fb99,refuted); 1::status(o_1cdbf820ca243bd3fb99,unknown).
0::status(o_38d0a19e8e5dac6d4159,supported); 0::status(o_38d0a19e8e5dac6d4159,refuted); 1::status(o_38d0a19e8e5dac6d4159,unknown).
0.99999984364086103::status(o_5ce9614d056c0e559071,supported); 1.1861119710704782e-08::status(o_5ce9614d056c0e559071,refuted); 1.4449801924284193e-07::status(o_5ce9614d056c0e559071,unknown).
1.300506440179514e-05::status(o_7befa1451684e2503e41,supported); 0.00015843411853342902::status(o_7befa1451684e2503e41,refuted); 0.99982856081706484::status(o_7befa1451684e2503e41,unknown).
0.99999770743316174::status(o_97495214205925702e3d,supported); 3.2241804986416688e-08::status(o_97495214205925702e3d,refuted); 2.2603250333742389e-06::status(o_97495214205925702e3d,unknown).
0.99999999438638487::status(o_b00c88c5e7f9454fa7b1,supported); 1.2501528593688655e-09::status(o_b00c88c5e7f9454fa7b1,refuted); 4.3634622284489044e-09::status(o_b00c88c5e7f9454fa7b1,unknown).
0::status(o_c8ea06a7b650f2f2b949,supported); 0::status(o_c8ea06a7b650f2f2b949,refuted); 1::status(o_c8ea06a7b650f2f2b949,unknown).
0.9999977145650073::status(o_f336bbe2060a97d53642,supported); 2.5109943150137486e-08::status(o_f336bbe2060a97d53642,refuted); 2.2603250494945646e-06::status(o_f336bbe2060a97d53642,unknown).
and_state(supported,supported,supported).
and_state(supported,refuted,refuted).
and_state(supported,unknown,unknown).
and_state(refuted,supported,refuted).
and_state(refuted,refuted,refuted).
and_state(refuted,unknown,refuted).
and_state(unknown,supported,unknown).
and_state(unknown,refuted,refuted).
and_state(unknown,unknown,unknown).
or_state(supported,supported,supported).
or_state(supported,refuted,supported).
or_state(supported,unknown,supported).
or_state(refuted,supported,supported).
or_state(refuted,refuted,refuted).
or_state(refuted,unknown,unknown).
or_state(unknown,supported,supported).
or_state(unknown,refuted,unknown).
or_state(unknown,unknown,unknown).
not_state(supported,refuted).
not_state(refuted,supported).
not_state(unknown,unknown).
node(n2,Z) :- status(o_b00c88c5e7f9454fa7b1,Z).
node(n3,Z) :- status(o_f336bbe2060a97d53642,Z).
node(n1,Z) :- node(n2,A), node(n3,B), and_state(A,B,Z).
node(n5,Z) :- status(o_5ce9614d056c0e559071,Z).
node(n6,Z) :- status(o_97495214205925702e3d,Z).
node(n4,Z) :- node(n5,A), node(n6,B), and_state(A,B,Z).
node(n0,Z) :- node(n1,A), node(n4,B), and_state(A,B,Z).
verdict(c_48568e3955cf222e,Z) :- node(n0,Z).
query(verdict(c_48568e3955cf222e,supported)).
query(verdict(c_48568e3955cf222e,refuted)).
query(verdict(c_48568e3955cf222e,unknown)).
node(n9,Z) :- status(o_7befa1451684e2503e41,Z).
node(n8,Z) :- node(n2,A), node(n9,B), and_state(A,B,Z).
node(n11,Z) :- status(o_059efb40dc6588f5a7c3,Z).
node(n10,Z) :- node(n5,A), node(n11,B), and_state(A,B,Z).
node(n7,Z) :- node(n8,A), node(n10,B), and_state(A,B,Z).
verdict(c_8cb74db314c9ea54,Z) :- node(n7,Z).
query(verdict(c_8cb74db314c9ea54,supported)).
query(verdict(c_8cb74db314c9ea54,refuted)).
query(verdict(c_8cb74db314c9ea54,unknown)).
node(n14,Z) :- status(o_38d0a19e8e5dac6d4159,Z).
node(n15,Z) :- status(o_12708a8a192009601d34,Z).
node(n13,Z) :- node(n14,A), node(n15,B), and_state(A,B,Z).
node(n17,Z) :- status(o_c8ea06a7b650f2f2b949,Z).
node(n18,Z) :- status(o_1cdbf820ca243bd3fb99,Z).
node(n16,Z) :- node(n17,A), node(n18,B), and_state(A,B,Z).
node(n12,Z) :- node(n13,A), node(n16,B), and_state(A,B,Z).
verdict(c_0af1d2cec83cfc0c,Z) :- node(n12,Z).
query(verdict(c_0af1d2cec83cfc0c,supported)).
query(verdict(c_0af1d2cec83cfc0c,refuted)).
query(verdict(c_0af1d2cec83cfc0c,unknown)).
