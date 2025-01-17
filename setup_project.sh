#!/bin/bash

# MacOS用プロジェクトセットアップスクリプト

# プロジェクト名を入力
read -p "Enter project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    echo "Project name cannot be empty. Exiting."
    exit 1
fi

# プロジェクトディレクトリ作成
echo "Creating project directory..."
mkdir -p "$PROJECT_NAME"/{src,tests,docs,.vscode}

# ディレクトリ内に移動
cd "$PROJECT_NAME" || exit

# README.md と .gitignore を作成
echo "Creating README.md and .gitignore..."
echo "# $PROJECT_NAME" > README.md
echo "__pycache__/" > .gitignore

# Python仮想環境を作成
echo "Setting up virtual environment..."
python3 -m venv venv
if [ $? -ne 0 ]; then
    echo "Failed to create virtual environment. Ensure Python3 is installed."
    exit 1
fi
source venv/bin/activate

# pip をアップグレード
echo "Upgrading pip..."
pip install --upgrade pip

# 必要なPythonパッケージをインストール
echo "Installing Python dependencies..."
pip install black flake8 pytest

# VSCodeの設定ファイルを作成
echo "Creating VSCode settings..."
cat << EOF > .vscode/settings.json
{
    "python.pythonPath": "\${workspaceFolder}/venv/bin/python",
    "python.formatting.provider": "black",
    "editor.formatOnSave": true
}
EOF

# 完了メッセージ
echo "Project setup complete! Navigate to $PROJECT_NAME and start coding."
