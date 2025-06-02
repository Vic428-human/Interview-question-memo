
# 前言
從gitlab clone專案下來的時候，所需要的ssh配置。

SSH 配置指南
此指南将帮助您配置 SSH，以便从 GitLab 克隆项目并进行安全的连接。
前言
在使用 GitLab 克隆项目之前，您需要设置 SSH 密钥。
生成 SSH 密鑰
您可以使用以下命令生成一个 Ed25519 类型的 SSH 密钥对：
ssh-keygen -t ed25519 -C "test@example.net"

 * 此命令将生成一个 Ed25519 类型的 SSH 密钥对，并带有 "test@example.net" 的标签（注释）。
 * 默认情况下，私钥将存储在 ~/.ssh/id_ed25519，公钥则存储在 ~/.ssh/id_ed25519.pub。
 * 潜在问题提示： -C "test@example.net" 仅是密鑰的标签，不会影响文件名称。请确保在提示时按 Enter 接受默认文件名称 (id_ed25519)，否则后续步骤可能会因文件名称不符而失败。
啟動 SSH 代理
启动 SSH 代理是管理私钥的必要步骤。执行以下命令：
eval $(ssh-agent -s)

 * 此命令会启动 SSH 代理，并返回代理的进程 ID（例如 Agent pid 13001）。
添加私鑰到 SSH 代理
进入 .ssh 目录并添加您的私钥：
cd .ssh
ssh-add ~/.ssh/id_ed25519

 * 重要提示： 如果您在生成密钥时接受了默认文件名称，私钥应为 ~/.ssh/id_ed25519。
 * 请注意，如果您的私钥文件名不是 id_ed25519（例如您之前指定了自定义文件名为 gitlab_key），则需要将上述命令中的 id_ed25519 替换为您的实际私钥文件名。
修改密鑰密碼 (可選)
如果您想更改私钥的密码，可以使用以下命令。如果您在第一步中没有设置密码（直接按 Enter），或者不需要更改密码，可以跳过此步骤。
ssh-keygen -p -f ~/.ssh/id_ed25519

測試 SSH 連線
在您将公钥添加到 GitLab 之前，测试 SSH 连接可能会显示 Permission denied (publickey)。
ssh -T git@gitlab.com

 * 此时，您可能会看到 git@gitlab.com: Permission denied (publickey) 的错误信息。这是正常的，因为您尚未将公钥添加到 GitLab。
將公鑰添加到 GitLab
最后一步是将您的公钥内容复制并粘贴到 GitLab 的设置中。
 * 打开您的公钥文件 ~/.ssh/id_ed25519.pub。
 * 复制文件中的所有内容。
 * 登录到 GitLab。
 * 导航到您的用户设置中的 SSH Keys 部分。
 * 将复制的公钥内容粘贴到相应的字段中。
 * 保存设置。
完成此步骤后，您的 SSH 连接将不再失败。
