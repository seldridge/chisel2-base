A bare-bones Chisel build environment.

This is an attempt to standardize on a build environment for personal Chisel projects. This consists of a basic, Makefile-driven workflow. Scala or C/C++ sources live in the `src` directory and the outputs of the build flow go in `build`.

This is currently only supports testing in Scala (as opposed to testing via the C++ or Verilog back ends). **The extremely useful C++ back end support will be included later on**.

Two Chisel examples (from the Chisel tutorial) are currently included: a full adder and a 4-bit adder using that full adder design.
