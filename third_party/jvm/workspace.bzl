# Do not edit. bazel-deps autogenerates this file from third_party/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        executable = False,
    )
    src_name = "%s-sources.jar" % ctx.name
    srcjar_attr = ""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output = ctx.path("jar/%s" % src_name),
            url = ctx.attr.src_urls,
            sha256 = ctx.attr.src_sha256,
            executable = False,
        )
        srcjar_attr = '\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default = ""),
        "src_urls": attr.string_list(mandatory = False, default = []),
    },
    implementation = _jar_artifact_impl,
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source = hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256,
    )
    native.bind(name = hash["bind"], actual = hash["actual"])

def list_dependencies():
    return [
        {
            "artifact": "com.google.auto.service:auto-service:1.0-rc4",
            "lang": "java",
            "sha1": "44954d465f3b9065388bbd2fc08a3eb8fd07917c",
            "sha256": "e422d49c312fd2031222e7306e8108c1b4118eb9c049f1b51eca280bed87e924",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/auto/service/auto-service/1.0-rc4/auto-service-1.0-rc4.jar",
            "source": {
                "sha1": "4e0285a57f33a9139e203687a617d7c98104b73a",
                "sha256": "285a6d4bc111255b5c99f5393b833f8b9156c4acb4e6c3f7cdde8493e888dd27",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/auto/service/auto-service/1.0-rc4/auto-service-1.0-rc4-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_auto_service_auto_service",
            "actual": "@io_bazel_rules_kotlin_com_google_auto_service_auto_service//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/auto/service/auto_service"
        }, {
            "artifact": "com.google.auto.value:auto-value:1.5.3",
            "lang": "java",
            "sha1": "514df6a7c7938de35c7f68dc8b8f22df86037f38",
            "sha256": "238d3b7535096d782d08576d1e42f79480713ff0794f511ff2cc147363ec072d",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/auto/value/auto-value/1.5.3/auto-value-1.5.3.jar",
            "source": {
                "sha1": "1bb4def82e18be0b6a58ab089fba288d712db6cb",
                "sha256": "7c9adb9f49a4f07e226778951e087da85759a9ab53ac375f9d076de6dc84ca2b",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/auto/value/auto-value/1.5.3/auto-value-1.5.3-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_auto_value_auto_value",
            "actual": "@io_bazel_rules_kotlin_com_google_auto_value_auto_value//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/auto/value/auto_value"
        }, {
            "artifact": "com.google.auto:auto-common:0.8",
            "lang": "java",
            "sha1": "c6f7af0e57b9d69d81b05434ef9f3c5610d498c4",
            "sha256": "97db1709f57b91b32edacb596ef4641872f227b7d99ad90e467f0d77f5ba134a",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/auto/auto-common/0.8/auto-common-0.8.jar",
            "source": {
                "sha1": "24705cafc9997c5eb6ae3270bd6234fdf9912bad",
                "sha256": "1e258bc08963dc8ffdcf22efa04b9fea6886761e077fc126ebacf92d11c9abec",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/auto/auto-common/0.8/auto-common-0.8-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_auto_auto_common",
            "actual": "@io_bazel_rules_kotlin_com_google_auto_auto_common//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/auto/auto_common"
        }, {
            "artifact": "com.google.code.findbugs:jsr305:3.0.2",
            "lang": "java",
            "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d",
            "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar",
            "source": {
                "sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35",
                "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_code_findbugs_jsr305",
            "actual": "@io_bazel_rules_kotlin_com_google_code_findbugs_jsr305//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/code/findbugs/jsr305"
        }, {
            "artifact": "com.google.code.gson:gson:2.7",
            "lang": "java",
            "sha1": "751f548c85fa49f330cecbb1875893f971b33c4e",
            "sha256": "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar",
            "source": {
                "sha1": "bbb63ca253b483da8ee53a50374593923e3de2e2",
                "sha256": "2d3220d5d936f0a26258aa3b358160741a4557e046a001251e5799c2db0f0d74",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_code_gson_gson",
            "actual": "@io_bazel_rules_kotlin_com_google_code_gson_gson//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/code/gson/gson"
        }, {
            "artifact": "com.google.dagger:dagger-compiler:2.16",
            "lang": "java",
            "sha1": "203235b0c6875c39a0b5053dfc2f043acab04acf",
            "sha256": "723dca807605ddc82cd86c4e334493789ad7fb3fe863b264a8853611c89baf3d",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-compiler/2.16/dagger-compiler-2.16.jar",
            "source": {
                "sha1": "7ceeb0333370b3f0c28f4b23b1db72d8aae5efa3",
                "sha256": "05dbe0867bd1efce9a446359d30a0ad2bfe0407b1afd2b31a3058944d2bf3a7d",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-compiler/2.16/dagger-compiler-2.16-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_dagger_dagger_compiler",
            "actual": "@io_bazel_rules_kotlin_com_google_dagger_dagger_compiler//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/dagger/dagger_compiler"
        }, {
            "artifact": "com.google.dagger:dagger-producers:2.16",
            "lang": "java",
            "sha1": "4e084a99b71a31e7079603c9675cb4994aff1344",
            "sha256": "97737907bde6e94cfa90883fa2a8ff4765400b9561bdcb4d83fe475ddbaf22af",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-producers/2.16/dagger-producers-2.16.jar",
            "source": {
                "sha1": "b477b4eebb171e718c7c9c4e4968913e50cf8e52",
                "sha256": "93838ce482666e54ed7a10d97558db99fce7c761392db44c259805e66664f384",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-producers/2.16/dagger-producers-2.16-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_dagger_dagger_producers",
            "actual": "@io_bazel_rules_kotlin_com_google_dagger_dagger_producers//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/dagger/dagger_producers"
        }, {
            "artifact": "com.google.dagger:dagger-spi:2.16",
            "lang": "java",
            "sha1": "26da9b6bf60185ca6f42da51bc20d93b2c825661",
            "sha256": "1b14f73b7c1088ab399f9fcf9f98aecba7a51d9fbfeeb63c1ad5dab9aadbef86",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-spi/2.16/dagger-spi-2.16.jar",
            "source": {
                "sha1": "17302c42cf920a1af28c8400b39462a78b63f549",
                "sha256": "62442cb1017f3498a2e2528fe5ac5d965f51e65090fa21cf0df01fa240e1ab07",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger-spi/2.16/dagger-spi-2.16-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_dagger_dagger_spi",
            "actual": "@io_bazel_rules_kotlin_com_google_dagger_dagger_spi//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/dagger/dagger_spi"
        }, {
            "artifact": "com.google.dagger:dagger:2.16",
            "lang": "java",
            "sha1": "a54ab49a739fd87e31be49c6179a0e9a135a7f39",
            "sha256": "1d67ef12bb90bf68f6146f6b51f30a2e965277a53bee6da931c8fa163de29615",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger/2.16/dagger-2.16.jar",
            "source": {
                "sha1": "ec3a4ce62e7e75a5cba2fe04820b6cfe12003ddd",
                "sha256": "b131c5e094cde112217abbb3123e37ba5b80e74bed2debd3a3b567251179a898",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/dagger/dagger/2.16/dagger-2.16-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_dagger_dagger",
            "actual": "@io_bazel_rules_kotlin_com_google_dagger_dagger//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/dagger/dagger"
        }, {
            "artifact": "com.google.errorprone:error_prone_annotations:2.1.3",
            "lang": "java",
            "sha1": "39b109f2cd352b2d71b52a3b5a1a9850e1dc304b",
            "sha256": "03d0329547c13da9e17c634d1049ea2ead093925e290567e1a364fd6b1fc7ff8",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.1.3/error_prone_annotations-2.1.3.jar",
            "source": {
                "sha1": "990fe1fd48078a2befecdfcebcad8e6e1bd195a0",
                "sha256": "f6ef2b585876b007051df3947b080e0d64cdd5a58b59bc69debeb26bfc0432d7",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.1.3/error_prone_annotations-2.1.3-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_errorprone_error_prone_annotations",
            "actual": "@io_bazel_rules_kotlin_com_google_errorprone_error_prone_annotations//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/errorprone/error_prone_annotations"
        }, {
            "artifact": "com.google.errorprone:javac-shaded:9-dev-r4023-3",
            "lang": "java",
            "sha1": "72b688efd290280a0afde5f9892b0fde6f362d1d",
            "sha256": "65bfccf60986c47fbc17c9ebab0be626afc41741e0a6ec7109e0768817a36f30",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/javac-shaded/9-dev-r4023-3/javac-shaded-9-dev-r4023-3.jar",
            "source": {
                "sha1": "63214c79029c5d9ff0b8205d2d50e02c4879b4d6",
                "sha256": "cf0fde1aad77ac6e0e2d36a9f9179193ae1707088ba00ffa91fcfb5269304a6a",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/javac-shaded/9-dev-r4023-3/javac-shaded-9-dev-r4023-3-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_errorprone_javac_shaded",
            "actual": "@io_bazel_rules_kotlin_com_google_errorprone_javac_shaded//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/errorprone/javac_shaded"
        }, {
            "artifact": "com.google.googlejavaformat:google-java-format:1.4",
            "lang": "java",
            "sha1": "c2f8925850e17caa6da0ed1891a9e9de9414c062",
            "sha256": "39d18ec9ab610097074bf49e971285488eaf5d0bc2369df0a0d5a3f9f9de2faa",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/googlejavaformat/google-java-format/1.4/google-java-format-1.4.jar",
            "source": {
                "sha1": "ba376ee8f9169ddbb6bc94d4fafa9869f1d2398d",
                "sha256": "4495352c9c9ac633c25c198cf23c0cd5ef56c5b3ffd911207748198ba8775a07",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/googlejavaformat/google-java-format/1.4/google-java-format-1.4-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_googlejavaformat_google_java_format",
            "actual": "@io_bazel_rules_kotlin_com_google_googlejavaformat_google_java_format//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/googlejavaformat/google_java_format"
        }, {
            # duplicates in com.google.guava:guava fixed to 25.0-jre
            # - com.google.auto.service:auto-service:1.0-rc4 wanted version 23.5-jre
            # - com.google.auto:auto-common:0.8 wanted version 19.0
            # - com.google.dagger:dagger-compiler:2.16 wanted version 23.3-jre
            # - com.google.dagger:dagger-producers:2.16 wanted version 23.3-jre
            # - com.google.dagger:dagger-spi:2.16 wanted version 23.3-jre
            # - com.google.googlejavaformat:google-java-format:1.4 wanted version 19.0
            # - com.google.protobuf:protobuf-java-util:3.6.0 wanted version 19.0
            # - com.google.truth:truth:0.40 wanted version 23.4-android
            "artifact": "com.google.guava:guava:25.0-jre",
            "lang": "java",
            "sha1": "7319c34fa5866a85b6bad445adad69d402323129",
            "sha256": "3fd4341776428c7e0e5c18a7c10de129475b69ab9d30aeafbb5c277bb6074fa9",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/25.0-jre/guava-25.0-jre.jar",
            "source": {
                "sha1": "030ade485699e7782cc2369b0e5d3d8e0bfc317c",
                "sha256": "386e429ab4f9e511630038e7b7a331d3dca3931564f592e412ba47995fefd89b",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/25.0-jre/guava-25.0-jre-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_guava_guava",
            "actual": "@io_bazel_rules_kotlin_com_google_guava_guava//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/guava/guava"
        }, {
            "artifact": "com.google.j2objc:j2objc-annotations:1.1",
            "lang": "java",
            "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019",
            "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar",
            "source": {
                "sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff",
                "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_j2objc_j2objc_annotations",
            "actual": "@io_bazel_rules_kotlin_com_google_j2objc_j2objc_annotations//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/j2objc/j2objc_annotations"
        }, {
            "artifact": "com.google.protobuf:protobuf-java-util:3.6.0",
            "lang": "java",
            "sha1": "3680d0042d4fe0b95ada844ff24da0698a7f0773",
            "sha256": "ad7f8d67674906ce88077fbb233b427b7068991a61af42ce9301990bdf8f3605",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java-util/3.6.0/protobuf-java-util-3.6.0.jar",
            "source": {
                "sha1": "1ac9d14befa9c98d382529dafa562a2dd4650011",
                "sha256": "a2959842caed6f0b1dbecfaf0e73ef03117416f967c0532c32d092b6e2b98d60",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java-util/3.6.0/protobuf-java-util-3.6.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_protobuf_protobuf_java_util",
            "actual": "@io_bazel_rules_kotlin_com_google_protobuf_protobuf_java_util//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/protobuf/protobuf_java_util"
        }, {
            "artifact": "com.google.protobuf:protobuf-java:3.6.0",
            "lang": "java",
            "sha1": "5333f7e422744d76840c08a106e28e519fbe3acd",
            "sha256": "8c8a65be83e75ccdcaa21417e303025f1708ea01e8c0a05d6c770e64b6c09ea1",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.6.0/protobuf-java-3.6.0.jar",
            "source": {
                "sha1": "6013b3453e0c102a8bd330d37f8e6918ce431882",
                "sha256": "88411bb0333725b27bf53ed4d95785f6f4b541e22e1e27c60c2be8b3115fc5c4",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.6.0/protobuf-java-3.6.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_protobuf_protobuf_java",
            "actual": "@io_bazel_rules_kotlin_com_google_protobuf_protobuf_java//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/protobuf/protobuf_java"
        }, {
            "artifact": "com.google.truth:truth:0.40",
            "lang": "java",
            "sha1": "0d74e716afec045cc4a178dbbfde2a8314ae5574",
            "sha256": "4868998229b155dcbe68416803975d491704f7cdb6847346cf9a49f65067d6fd",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/google/truth/truth/0.40/truth-0.40.jar",
            "source": {
                "sha1": "eb5b4f556cd0ae2a2afefb3ef2c9a8167692d0da",
                "sha256": "294e40be4ecbc8d7c25e6887774fcb004f178ea1dfa4988cfa7f2bc35516cf21",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/google/truth/truth/0.40/truth-0.40-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_google_truth_truth",
            "actual": "@io_bazel_rules_kotlin_com_google_truth_truth//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/google/truth/truth"
        }, {
            "artifact": "com.googlecode.java-diff-utils:diffutils:1.3.0",
            "lang": "java",
            "sha1": "7e060dd5b19431e6d198e91ff670644372f60fbd",
            "sha256": "61ba4dc49adca95243beaa0569adc2a23aedb5292ae78aa01186fa782ebdc5c2",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.jar",
            "source": {
                "sha1": "90b4aaa9530827fe6ad2b6684389c86999e861a3",
                "sha256": "7f4d40e97827f8a3285c3e47e8d28797ecfd45fb2ff94bd12cb6a83760a5f427",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_googlecode_java_diff_utils_diffutils",
            "actual": "@io_bazel_rules_kotlin_com_googlecode_java_diff_utils_diffutils//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/googlecode/java_diff_utils/diffutils"
        }, {
            "artifact": "com.squareup:javapoet:1.8.0",
            "lang": "java",
            "sha1": "e858dc62ef484048540d27d36f3ec2177a3fa9b1",
            "sha256": "8e108c92027bb428196f10fa11cffbe589f7648a6af2016d652279385fdfd789",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/com/squareup/javapoet/1.8.0/javapoet-1.8.0.jar",
            "source": {
                "sha1": "499341a875fe72e8fcf4ba856ba15f498d348e38",
                "sha256": "a086ec275dc21d7e6fcd5df51a02ab0cb35305b2fd3628ce23703d279d98b833",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/com/squareup/javapoet/1.8.0/javapoet-1.8.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_com_squareup_javapoet",
            "actual": "@io_bazel_rules_kotlin_com_squareup_javapoet//jar",
            "bind": "jar/io_bazel_rules_kotlin_com/squareup/javapoet"
        }, {
            "artifact": "javax.annotation:jsr250-api:1.0",
            "lang": "java",
            "sha1": "5025422767732a1ab45d93abfea846513d742dcf",
            "sha256": "a1a922d0d9b6d183ed3800dfac01d1e1eb159f0e8c6f94736931c1def54a941f",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0.jar",
            "source": {
                "sha1": "9b1fba77edd118e13c42bda43d3c993dadd52c25",
                "sha256": "025c47d76c60199381be07012a0c5f9e74661aac5bd67f5aec847741c5b7f838",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/javax/annotation/jsr250-api/1.0/jsr250-api-1.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_javax_annotation_jsr250_api",
            "actual": "@io_bazel_rules_kotlin_javax_annotation_jsr250_api//jar",
            "bind": "jar/io_bazel_rules_kotlin_javax/annotation/jsr250_api"
        }, {
            "artifact": "javax.inject:javax.inject:1",
            "lang": "java",
            "sha1": "6975da39a7040257bd51d21a231b76c915872d38",
            "sha256": "91c77044a50c481636c32d916fd89c9118a72195390452c81065080f957de7ff",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar",
            "source": {
                "sha1": "a00123f261762a7c5e0ec916a2c7c8298d29c400",
                "sha256": "c4b87ee2911c139c3daf498a781967f1eb2e75bc1a8529a2e7b328a15d0e433e",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/javax/inject/javax.inject/1/javax.inject-1-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_javax_inject_javax_inject",
            "actual": "@io_bazel_rules_kotlin_javax_inject_javax_inject//jar",
            "bind": "jar/io_bazel_rules_kotlin_javax/inject/javax_inject"
        }, {
            "artifact": "junit:junit:4.12",
            "lang": "java",
            "sha1": "2973d150c0dc1fefe998f834810d68f278ea58ec",
            "sha256": "59721f0805e223d84b90677887d9ff567dc534d7c502ca903c0c2b17f05c116a",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12.jar",
            "source": {
                "sha1": "a6c32b40bf3d76eca54e3c601e5d1470c86fcdfa",
                "sha256": "9f43fea92033ad82bcad2ae44cec5c82abc9d6ee4b095cab921d11ead98bf2ff",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/junit/junit/4.12/junit-4.12-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_junit_junit",
            "actual": "@io_bazel_rules_kotlin_junit_junit//jar",
            "bind": "jar/io_bazel_rules_kotlin_junit/junit"
        }, {
            # duplicates in org.checkerframework:checker-compat-qual promoted to 2.3.0
            # - com.google.dagger:dagger-producers:2.16 wanted version 2.3.0
            # - com.google.guava:guava:25.0-jre wanted version 2.0.0
            "artifact": "org.checkerframework:checker-compat-qual:2.3.0",
            "lang": "java",
            "sha1": "69cb4fea55a9d89b8827d107f17c985cc1a76052",
            "sha256": "7b2ebd4c746231525a93912fd66055639fc6a8a9dc28392bc1e0ae239011d5fc",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.3.0/checker-compat-qual-2.3.0.jar",
            "source": {
                "sha1": "5eec664fda8990bfec0470f5bd1dfbb4c6fcc300",
                "sha256": "7c2dc71de46e6b4de8c9a6a83375ae6b612c5d1d933e47c1ebd92c1c31a8a12e",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/checkerframework/checker-compat-qual/2.3.0/checker-compat-qual-2.3.0-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_checkerframework_checker_compat_qual",
            "actual": "@io_bazel_rules_kotlin_org_checkerframework_checker_compat_qual//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/checkerframework/checker_compat_qual"
        }, {
            "artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.14",
            "lang": "java",
            "sha1": "775b7e22fb10026eed3f86e8dc556dfafe35f2d5",
            "sha256": "2068320bd6bad744c3673ab048f67e30bef8f518996fa380033556600669905d",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-annotations-1.14.jar",
            "source": {
                "sha1": "886474da3f761d39fcbb723d97ecc5089e731f42",
                "sha256": "d821ae1f706db2c1b9c88d4b7b0746b01039dac63762745ef3fe5579967dd16b",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.14/animal-sniffer-annotations-1.14-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_codehaus_mojo_animal_sniffer_annotations",
            "actual": "@io_bazel_rules_kotlin_org_codehaus_mojo_animal_sniffer_annotations//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/codehaus/mojo/animal_sniffer_annotations"
        }, {
            "artifact": "org.hamcrest:hamcrest-core:1.3",
            "lang": "java",
            "sha1": "42a25dc3219429f0e5d060061f71acb49bf010a0",
            "sha256": "66fdef91e9739348df7a096aa384a5685f4e875584cce89386a7a47251c4d8e9",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar",
            "source": {
                "sha1": "1dc37250fbc78e23a65a67fbbaf71d2e9cbc3c0b",
                "sha256": "e223d2d8fbafd66057a8848cc94222d63c3cedd652cc48eddc0ab5c39c0f84df",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_hamcrest_hamcrest_core",
            "actual": "@io_bazel_rules_kotlin_org_hamcrest_hamcrest_core//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/hamcrest/hamcrest_core"
        }, {
            "artifact": "org.jetbrains.kotlin:kotlin-stdlib-common:1.3.11",
            "lang": "java",
            "sha1": "d8b8e746e279f1c4f5e08bc14a96b82e6bb1de02",
            "sha256": "75bdd11bedf5736a5b95bbdb643a8f920a9e801caa20f5335a499fa95dc8f9fc",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.11/kotlin-stdlib-common-1.3.11.jar",
            "source": {
                "sha1": "e49742d3259938ea3539346c8ca3babb54a5140f",
                "sha256": "e5103a37f3e24b929ffa95996831b4e6393b7ff60d3c612b2c02e0b20df9852b",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.3.11/kotlin-stdlib-common-1.3.11-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_jetbrains_kotlin_kotlin_stdlib_common",
            "actual": "@io_bazel_rules_kotlin_org_jetbrains_kotlin_kotlin_stdlib_common//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/jetbrains/kotlin/kotlin_stdlib_common"
        }, {
            "artifact": "org.jetbrains.kotlinx:atomicfu-common:0.11.2",
            "lang": "java",
            "sha1": "eb1de5f3b800992b2b72655ef8c595b4f11ee444",
            "sha256": "ef78e68140c10c3e186b67c219877c01ccd98ccd505b2463f86aec3ed243da0e",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/atomicfu-common/0.11.2/atomicfu-common-0.11.2.jar",
            "source": {
                "sha1": "5217a35c24d1b23df4dc0df62c777968b45f33f7",
                "sha256": "584e409f54aa23c4a91046f367775d6f8ceeb73ff0221d62d5c8073949ccdeae",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/atomicfu-common/0.11.2/atomicfu-common-0.11.2-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_jetbrains_kotlinx_atomicfu_common",
            "actual": "@io_bazel_rules_kotlin_org_jetbrains_kotlinx_atomicfu_common//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/jetbrains/kotlinx/atomicfu_common"
        }, {
            "artifact": "org.jetbrains.kotlinx:kotlinx-coroutines-core-common:1.0.1",
            "lang": "java",
            "sha1": "679991d1b388fd9392eeb3d63b10b3f4c284f389",
            "sha256": "1fb02f239ac87ab97d2b6478dca2ef769d4d20390a1e4d77ccf40bd4b45cf043",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-coroutines-core-common/1.0.1/kotlinx-coroutines-core-common-1.0.1.jar",
            "source": {
                "sha1": "16382dce10af5c4159654272de71e8c0efe854c7",
                "sha256": "e8bdce21224dd646c2d0eefc5398d507fcdfe5af4298c52de00147e3593b2c64",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-coroutines-core-common/1.0.1/kotlinx-coroutines-core-common-1.0.1-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_jetbrains_kotlinx_kotlinx_coroutines_core_common",
            "actual": "@io_bazel_rules_kotlin_org_jetbrains_kotlinx_kotlinx_coroutines_core_common//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/jetbrains/kotlinx/kotlinx_coroutines_core_common"
        }, {
            "artifact": "org.jetbrains.kotlinx:kotlinx-coroutines-core:1.0.1",
            "lang": "java",
            "sha1": "f33e8dab753f33d1bbb07cca664fd6f13d993d7e",
            "sha256": "1bbc516011181c35c23552f39584d9e1dcc46c2c38486c8e71d56060a6722a12",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-coroutines-core/1.0.1/kotlinx-coroutines-core-1.0.1.jar",
            "source": {
                "sha1": "b1cf01c9c43664298d84d9fd3342786142889538",
                "sha256": "9125cb95d723914133329239a9eb803be5b5d4feb609feb668782bd38eb07554",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/jetbrains/kotlinx/kotlinx-coroutines-core/1.0.1/kotlinx-coroutines-core-1.0.1-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_jetbrains_kotlinx_kotlinx_coroutines_core",
            "actual": "@io_bazel_rules_kotlin_org_jetbrains_kotlinx_kotlinx_coroutines_core//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/jetbrains/kotlinx/kotlinx_coroutines_core"
        }, {
            "artifact": "org.jetbrains:annotations:16.0.3",
            "lang": "java",
            "sha1": "62c7299ced2a089cc541726c6d763da9417604a0",
            "sha256": "04b16e8d2309bf7771fbee16187b76f63af6ccd023cf664ec846e4e8e65c5b3f",
            "repository": "https://repo.maven.apache.org/maven2/",
            "url": "https://repo.maven.apache.org/maven2/org/jetbrains/annotations/16.0.3/annotations-16.0.3.jar",
            "source": {
                "sha1": "c3bc8659eca392a635059c6cda7b1365dfbe5a43",
                "sha256": "4078864b304d14f01d1100eb3ed05a1c1a0ec9e82bac6351f101259ff9094049",
                "repository": "https://repo.maven.apache.org/maven2/",
                "url": "https://repo.maven.apache.org/maven2/org/jetbrains/annotations/16.0.3/annotations-16.0.3-sources.jar"
            },
            "name": "io_bazel_rules_kotlin_org_jetbrains_annotations",
            "actual": "@io_bazel_rules_kotlin_org_jetbrains_annotations//jar",
            "bind": "jar/io_bazel_rules_kotlin_org/jetbrains/annotations"
        },
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
