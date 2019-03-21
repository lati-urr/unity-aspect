# unity-aspect

画像を指定したアスペクト比に変更します．
その際，画像自身は拡大縮小したりせず，余白を足すような感じでアスペクト比を合わせます．

## Require

```
# Ubuntu 
sudo apt-get install imagemagick
# Gentoo
sudo emerge -v imagemagick
```

## Usage
./create-aspect-image.sh [ options ] IMAGE_FILE_PATH

Options:

-h, --help
-v, --version
-a, --aspect      weight:height(default 16:9)
-b, --background  #color(default clear)
-o, --output      DIR_PATH(default IMAGE_FILE_PATH_DIR)


output image file name is INPUT_FILE_NAME-resize

## Example

### > penguin.png

```
./create-aspect-image.sh penguin.png
```

### > penguin2.png

```
./create-aspect-image.sh -b #97d4d9 penguin.png
```

### > penguin3.png

```
./create-aspect-image.sh -b #97d4d9 -a 3:2 penguin.png
```

### > penguin4.png

