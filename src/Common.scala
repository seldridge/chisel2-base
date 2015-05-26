package architecture

import Chisel._

object Testbench {
  def main(args: Array[String]): Unit = {
    val cliArgs = args.slice(1, args.length)
    val res =
      args(0) match {
        case "Adder4" =>
         chiselMainTest(cliArgs, () => Module(new Adder4)) {
           c => new Adder4Tests(c, true)}
        // If using Chisel-style parameters, you need to use a
        // statement like the following:
        // case "Adder4" => chiselMain.run(cliArgs, () => new Adder4)
        case "FullAdder" =>
         chiselMainTest(cliArgs, () => Module(new FullAdder)) {
           c => new FullAdderTests(c, true)}
      }
  }
}
