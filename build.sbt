// Common settings that could be shared between projects as based on
// the sbt quickstart
lazy val commonSettings = Seq(
  // The organization used to populate the target sub-directoriers
  organization := "bu.edu",
  // A version number (largely unimportant)
  version := "0.1.0",
  // The version of Scala to use. I see no reason why this shouldn't
  // be the newest version.
  scalaVersion := "2.11.6",
  // scalaVersion := "2.10.4",
  // Usually you don't care about the trace (as it provides no useful
  // information), unless sbt, scala, or java shit the bed. This can
  // be upped to a high number (e.g., 100) to get the full trace.
  traceLevel := 0,
  // Change the src directory to ./src
  scalaSource in Compile := baseDirectory.value / "src"
)

// Based on 'chisel-tutorial/examples/chisel-dependent.sbt'. If a
// command line 'chiselVersion' is defined, then that will be used.
// Otherwise, this will default to the latest.release version of
// Chisel.
// val chiselVersion = System.getProperty("chiselVersion", "latest.release")
// val chiselVersion = System.getProperty("chiselVersion", "2.3-SNAPSHOT")

// This will track the latest reslease of Chisel (i.e., 2.x.x) as
// found in the Maven repository for the specified Scala version
// above.
val chisel = "edu.berkeley.cs" %% "chisel" % "latest.release"
// If you need bleeding edge support, build Chisel locally and use
// "2.3-SNAPSHOT" which will be the locally built version (assumedly
// from the Head of Berkeley's master branch)
// val chisel = "edu.berkeley.cs" %% "chisel" % "2.3-SNAPSHOT"

// Set the actual settings as defined above
lazy val root = (project in file(".")).
  settings(commonSettings: _*).
  settings(
    name := "architecture",
    libraryDependencies += chisel,
    scalacOptions ++= Seq("-deprecation", "-feature", "-unchecked", "-language:reflectiveCalls")
  )
