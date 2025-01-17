[![Build status](https://badge.buildkite.com/a8860e94a7378491ce8f50480e3605b49eb2558cfa851bbf9b.svg)](https://buildkite.com/bazel/kotlin-postsubmit)

[Skydoc documentation](https://bazelbuild.github.io/rules_kotlin)

# A fork of kotlin_rules for Kotlin 1.3 by Daniel Loreto
As of December 3, 2018, the official version of kotlin_rules does not support Kotlin 1.3. This fork updates the rules so that the use the 1.3.10 release of the Kotlin compiler.

For it to work with Bazel 0.20.0 it required the following bazelrc file:
```
build --incompatible_use_remotejdk_as_host_javabase
```

That flag will be set to true by default in Bazel 0.21 so the need for it will go away.

Other Limitations:
+ Kotlin 1.3 removes the need for a runtime library. As a result I've removed that dependency from the Bazel rules. That means that you can not use this fork for both 1.3 and 1.2 versions of Kotlin.
+ The test suite should be expanded more to test 1.3 specific features.

# Announcements
* <b>April 1, 2019.</b> [Roadmap](https://github.com/bazelbuild/rules_kotlin/blob/master/ROADMAP.md) for rules_kotlin published.
* <b>February 20, 2019.</b> [Future directions](https://github.com/bazelbuild/rules_kotlin/issues/174) of rules_kotlin.
* <b>August 14, 2018.</b> Js support. No documentation yet but see the nested example workspace `examples/node`.
* <b>August 14, 2018.</b> Android support. No documentation but it's a simple integration. see
  `kotlin/internal/jvm/android.bzl`.
* <b>Jun 29, 2018.</b> The commits from this date forward are compatible with bazel `>=0.14`. JDK9 host issues were
  fixed as well some other deprecations. I recommend skipping `0.15.0` if you   are on a Mac.
* <b>May 25, 2018.</b> Test "friend" support. A single friend dep can be provided to `kt_jvm_test` which allows the test
  to access internal members of the module under test.
* <b>February 15, 2018.</b> Toolchains for the JVM rules. Currently this allow tweaking:
    * The JVM target (bytecode level).
    * API and Language levels.
    * Coroutines, enabled by default.
* <b>February 9, 2018.</b> Annotation processing.
* <b>February 5, 2018. JVM rule name change:</b> the prefix has changed from `kotlin_` to `kt_jvm_`.

# Overview

These rules were initially forked from [pubref/rules_kotlin](http://github.com/pubref/rules_kotlin).
Key changes:

* Replace the macros with three basic rules. `kt_jvm_binary`, `kt_jvm_library` and `kt_jvm_test`.
* Use a single dep attribute instead of `java_dep` and `dep`.
* Add support for the following standard java rules attributes:
  * `data`
  * `resource_jars`
  * `runtime_deps`
  * `resources`
  * `resources_strip_prefix`
  * `exports`
* Persistent worker support.
* Mixed-Mode compilation (compile Java and Kotlin in one pass).

# Quick Guide
This section just contains a quick overview. Consult the generated
[documentation](https://bazelbuild.github.io/rules_kotlin). Note: Skydoc documentation is no longer being generated.
Comprehensive documentation will have to wait till the new documentation generation tool is ready. A contribution to
port the documentation to the RST format like `rules_go` has would be very welcome !


## WORKSPACE
In the project's `WORKSPACE`, declare the external repository and initialize the toolchains, like
this:

```build
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

rules_kotlin_version = "67f4a6050584730ebae7f8a40435a209f8e0b48e"

http_archive(
    name = "io_bazel_rules_kotlin",
    urls = ["https://github.com/bazelbuild/rules_kotlin/archive/%s.zip" % rules_kotlin_version],
    type = "zip",
    strip_prefix = "rules_kotlin-%s" % rules_kotlin_version
)

load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kotlin_repositories", "kt_register_toolchains")
kotlin_repositories()
kt_register_toolchains()
```

## BUILD files

In your project's `BUILD` files, load the kotlin rules and use them like so:

```
load("@io_bazel_rules_kotlin//kotlin:kotlin.bzl", "kt_jvm_library")

kt_jvm_library(
    name = "package_name",
    srcs = glob(["*.kt"]),
    deps = [
        "//path/to/dependency",
    ],
)
```

# License

This project is licensed under the [Apache 2.0 license](LICENSE), as are all contributions

# Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) doc for information about how to contribute to
this project.
