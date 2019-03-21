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


出力ファイル名は入力ファイル名の末尾に-resizeをつけたものになります．  
(ex. penguin.png -> penguin-resize.png)

## Example

### > penguin.png

![penguin](https://user-images.githubusercontent.com/34452361/54757421-892a4980-4c2d-11e9-8939-8a3af39ac0ec.png)


### > penguin2.png
```
./create-aspect-image.sh penguin.png
```
![penguin2](https://user-images.githubusercontent.com/34452361/54757450-99422900-4c2d-11e9-8993-0717b559925b.png)

### > penguin3.png
```
./create-aspect-image.sh -b #97d4d9 penguin.png
```
![penguin3](https://user-images.githubusercontent.com/34452361/54757518-bc6cd880-4c2d-11e9-8086-9270c173d646.png)

### > penguin4.png
```
./create-aspect-image.sh -b #97d4d9 -a 3:2 penguin.png
```
![penguin4](https://user-images.githubusercontent.com/34452361/54757548-c2fb5000-4c2d-11e9-9342-ad6efdfaa746.png)
