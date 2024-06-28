# AutoLang

## Installation

...

### Configuration

Create/update the file `~/.config/autolang/config.yaml`.

Example:
```shell
tracked_apps:
  - name: "com.apple.Safari"
    language: "com.apple.keylayout.Swedish-Pro"
  - name: "com.apple.dt.Xcode"
    language: "com.apple.keylayout.US"
```

#### Get `bundleid` from application:
```shell
osascript -e 'id of app "Safari"'
com.apple.Safari
```

#### Get installed `input-sources`

```shell
swift input-sources.swift
```

## Usage

```shell
swift build
swift run AutoLang
```