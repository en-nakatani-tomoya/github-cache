# GitHub Actions Docker ビルドキャッシュのサンプル

このリポジトリは、GitHub Actionsでdockerビルドのキャッシュを利用する方法を示すシンプルな例です。

## 概要

このプロジェクトでは、GitHub Actionsの`type=gha`キャッシュ機能を使用して、Dockerイメージのビルド時間を短縮する方法を示しています。

キャッシュを利用すると：
- ベースイメージのpullが毎回行われなくなる
- ビルドレイヤーが再利用される
- ビルド時間が大幅に短縮される

## ファイル構成

- `Dockerfile` - シンプルなnginxベースのWebサーバー
- `docker-compose.yaml` - ローカル開発用の設定
- `.github/workflows/build.yml` - GitHub Actionsワークフロー（キャッシュ利用）

## キャッシュの仕組み

ワークフローでは以下の設定でDockerビルドキャッシュを有効にしています：

```yaml
- name: Build and push with GitHub Actions cache
  uses: docker/build-push-action@v5
  with:
    context: .
    push: ${{ github.event_name != 'pull_request' }}
    tags: ghcr.io/${{ github.repository }}/app:latest
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

これにより、GitHub Actionsのキャッシュ機能を利用してDocker buildのレイヤーキャッシュが行われます。

## ローカルでの実行

```bash
docker-compose up -d
```

## 参考リンク

- [Docker公式ドキュメント - GitHub Actions cache](https://docs.docker.com/build/cache/backends/gha/)
- [GitHub Actions - docker/build-push-action](https://github.com/docker/build-push-action) 