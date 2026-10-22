% Generated categorical evidence and explicit supported/refuted/unknown composition.
0.01::status(o_0730ec90cb8e8dc9b5a3,supported); 0.95999999999999996::status(o_0730ec90cb8e8dc9b5a3,refuted); 0.029999999999999999::status(o_0730ec90cb8e8dc9b5a3,unknown).
0.01::status(o_1eadd4bd167491f2bf1a,supported); 0.95999999999999996::status(o_1eadd4bd167491f2bf1a,refuted); 0.029999999999999999::status(o_1eadd4bd167491f2bf1a,unknown).
0.01::status(o_2a4b027376c9f8696e29,supported); 0.95999999999999996::status(o_2a4b027376c9f8696e29,refuted); 0.029999999999999999::status(o_2a4b027376c9f8696e29,unknown).
1::status(o_3b1a3ce6bf1269c0f37f,supported); 0::status(o_3b1a3ce6bf1269c0f37f,refuted); 0::status(o_3b1a3ce6bf1269c0f37f,unknown).
0.01::status(o_3b296a9c30650d87d1b6,supported); 0.95999999999999996::status(o_3b296a9c30650d87d1b6,refuted); 0.029999999999999999::status(o_3b296a9c30650d87d1b6,unknown).
0.94999999999999996::status(o_3fb8915ff251ab11b75e,supported); 0.02::status(o_3fb8915ff251ab11b75e,refuted); 0.029999999999999999::status(o_3fb8915ff251ab11b75e,unknown).
0.01::status(o_a97aeeee210cc0d5c9fb,supported); 0.95999999999999996::status(o_a97aeeee210cc0d5c9fb,refuted); 0.029999999999999999::status(o_a97aeeee210cc0d5c9fb,unknown).
0.98999999999999999::status(o_ae9d541f4713a931f94b,supported); 0.0050000000000000001::status(o_ae9d541f4713a931f94b,refuted); 0.0050000000000000001::status(o_ae9d541f4713a931f94b,unknown).
1::status(o_e876b0d7e5bb8cbaad09,supported); 0::status(o_e876b0d7e5bb8cbaad09,refuted); 0::status(o_e876b0d7e5bb8cbaad09,unknown).
0.98999999999999999::status(o_f2361216964fc16e0e74,supported); 0.0050000000000000001::status(o_f2361216964fc16e0e74,refuted); 0.0050000000000000001::status(o_f2361216964fc16e0e74,unknown).
0.98999999999999999::status(o_f4d188cd731f2622a2c9,supported); 0.0050000000000000001::status(o_f4d188cd731f2622a2c9,refuted); 0.0050000000000000001::status(o_f4d188cd731f2622a2c9,unknown).
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
node(n1,Z) :- status(o_f4d188cd731f2622a2c9,Z).
node(n2,Z) :- status(o_ae9d541f4713a931f94b,Z).
node(n5,Z) :- status(o_3b1a3ce6bf1269c0f37f,Z).
node(n6,Z) :- status(o_3fb8915ff251ab11b75e,Z).
node(n4,Z) :- node(n5,A), node(n6,B), and_state(A,B,Z).
node(n8,Z) :- status(o_e876b0d7e5bb8cbaad09,Z).
node(n9,Z) :- status(o_2a4b027376c9f8696e29,Z).
node(n7,Z) :- node(n8,A), node(n9,B), and_state(A,B,Z).
node(n3,Z) :- node(n4,A), node(n7,B), or_state(A,B,Z).
node(n0_fold0,Z) :- node(n1,A), node(n2,B), and_state(A,B,Z).
node(n0,Z) :- node(n0_fold0,A), node(n3,B), and_state(A,B,Z).
verdict(c_2271b6b056b84b09,Z) :- node(n0,Z).
query(verdict(c_2271b6b056b84b09,supported)).
query(verdict(c_2271b6b056b84b09,refuted)).
query(verdict(c_2271b6b056b84b09,unknown)).
node(n11,Z) :- status(o_f2361216964fc16e0e74,Z).
node(n14,Z) :- status(o_a97aeeee210cc0d5c9fb,Z).
node(n13,Z) :- node(n5,A), node(n14,B), and_state(A,B,Z).
node(n16,Z) :- status(o_1eadd4bd167491f2bf1a,Z).
node(n15,Z) :- node(n8,A), node(n16,B), and_state(A,B,Z).
node(n12,Z) :- node(n13,A), node(n15,B), or_state(A,B,Z).
node(n10_fold0,Z) :- node(n1,A), node(n11,B), and_state(A,B,Z).
node(n10,Z) :- node(n10_fold0,A), node(n12,B), and_state(A,B,Z).
verdict(c_263b91716e21f310,Z) :- node(n10,Z).
query(verdict(c_263b91716e21f310,supported)).
query(verdict(c_263b91716e21f310,refuted)).
query(verdict(c_263b91716e21f310,unknown)).
node(n20,Z) :- status(o_0730ec90cb8e8dc9b5a3,Z).
node(n19,Z) :- node(n5,A), node(n20,B), and_state(A,B,Z).
node(n22,Z) :- status(o_3b296a9c30650d87d1b6,Z).
node(n21,Z) :- node(n8,A), node(n22,B), and_state(A,B,Z).
node(n18,Z) :- node(n19,A), node(n21,B), or_state(A,B,Z).
node(n17_fold0,Z) :- node(n2,A), node(n1,B), and_state(A,B,Z).
node(n17,Z) :- node(n17_fold0,A), node(n18,B), and_state(A,B,Z).
verdict(c_6b6aa3e54a3ae5e0,Z) :- node(n17,Z).
query(verdict(c_6b6aa3e54a3ae5e0,supported)).
query(verdict(c_6b6aa3e54a3ae5e0,refuted)).
query(verdict(c_6b6aa3e54a3ae5e0,unknown)).
