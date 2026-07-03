require "language/node"

class CcViewer < Formula
  desc "Vibe Coding toolkit for Claude Code with Web Viewer + Logger"
  homepage "https://github.com/weiesky/cc-viewer"
  # NOTE: url + sha256 自动由 .github/workflows/bump-homebrew.yml 维护，发版后会跨 repo PR 更新
  url "https://registry.npmjs.org/cc-viewer/-/cc-viewer-1.6.334.tgz"
  sha256 "8012b9c8587f25909cbe0c7f8118083b7a4287a7d88a979c260dd669b63dc8be"
  license "MIT"

  depends_on "node"

  def install
    # Language::Node.std_npm_install_args(libexec) 处理 prefix、cache 隔离、--omit=dev 等标准项
    # 注：std_npm_install_args 是 Homebrew 当前推荐的 npm 安装参数生成器
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    # 关键：自写一个 sh wrapper 取代 npm 默认生成的 #!/usr/bin/env node shim。
    # 默认 shim 跟着 PATH 解析 node，nvm 切版本时会拿到 nvm 的 node 而不是 brew node，
    # node-pty 的 native binding 跨 Node 大版本会 ABI 失配。强绑 brew node 让 ccv
    # 永远跑在安装时编译的 Node ABI 上。
    (bin/"ccv").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" \
        "#{libexec}/lib/node_modules/cc-viewer/cli.js" "$@"
    SH
    (bin/"ccv").chmod 0755
  end

  test do
    # ccv -h 应当退出 0 并输出含 "ccv" 的帮助文本
    assert_match "ccv", shell_output("#{bin}/ccv -h 2>&1", 0)
    # 版本号应与 formula 一致
    assert_match version.to_s, shell_output("#{bin}/ccv --version 2>&1", 0)
  end
end
