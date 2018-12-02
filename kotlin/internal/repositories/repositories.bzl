# Copyright 2018 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""This file contains the Kotlin compiler repository definitions. It should not be loaded directly by client workspaces.
"""

load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    _http_archive = "http_archive",
    _http_file = "http_file",
)
load(
    "//kotlin/internal:defs.bzl",
    _KT_COMPILER_REPO = "KT_COMPILER_REPO",
)
load(
    "//third_party/jvm:workspace.bzl",
    _maven_dependencies = "maven_dependencies",
)

_BAZEL_JAVA_LAUNCHER_VERSION = "0.20.0"

_KOTLIN_CURRENT_COMPILER_RELEASE = {
    "urls": [
        "https://github.com/JetBrains/kotlin/releases/download/v1.3.0/kotlin-compiler-1.3.0.zip",
    ],
    "sha256": "ff851cb84dd12df6078ae1f4a5424de9be6dcb4ac578b35455eeb7106dc52592",
}

def github_archive(name, repo, commit, build_file_content = None):
    if build_file_content:
        _http_archive(
            name = name,
            strip_prefix = "%s-%s" % (repo.split("/")[1], commit),
            url = "https://github.com/%s/archive/%s.zip" % (repo, commit),
            type = "zip",
            build_file_content = build_file_content,
        )
    else:
        _http_archive(
            name = name,
            strip_prefix = "%s-%s" % (repo.split("/")[1], commit),
            url = "https://github.com/%s/archive/%s.zip" % (repo, commit),
            type = "zip",
        )

def kotlin_repositories(compiler_release = _KOTLIN_CURRENT_COMPILER_RELEASE):
    """Call this in the WORKSPACE file to setup the Kotlin rules.

    Args:
        compiler_release: (internal) dict containing "urls" and "sha256" for the Kotlin compiler.
    """
    _maven_dependencies()
    _http_archive(
        name = _KT_COMPILER_REPO,
        urls = compiler_release["urls"],
        sha256 = compiler_release["sha256"],
        build_file = "@io_bazel_rules_kotlin//kotlin/internal/repositories:BUILD.com_github_jetbrains_kotlin",
        strip_prefix = "kotlinc",
    )

    _http_file(
        name = "kt_java_stub_template",
        urls = [("https://raw.githubusercontent.com/bazelbuild/bazel/" +
                 _BAZEL_JAVA_LAUNCHER_VERSION +
                 "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
                 "java_stub_template.txt")],
        sha256 = "1483b4ab1a3e8dd6754db50098d9d904533797777e6c3872425b5b1787138935",
    )
