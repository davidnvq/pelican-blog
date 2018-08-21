Title: Convolution visualization
Slug: convolution-visualization
Date: 2018-08-21 16:53:40
Tags: CNN, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

<div class="article-style" itemprop="articleBody">
  <p>This post attributes to Vincent Dumoulin, Francesco Visin - A guide to convolution arithmetic for deep learning(<a href="https://gist.github.com/fvisin/165ca9935392fa9600a6c94664a01214" target="_blank">BibTeX</a>) for the nice visualization.
  </p>

  <h2 id="convolution-animations">Convolution animations</h2>

  <p><em>N.B.: Blue maps are inputs, and cyan maps are outputs.</em></p>

  <table style="width:100%; table-layout:fixed;">
    <tr>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/no_padding_no_strides.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/arbitrary_padding_no_strides.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/same_padding_no_strides.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/full_padding_no_strides.gif"></td>
    </tr>
    <tr>
      <td>No padding, no strides</td>
      <td>Arbitrary padding, no strides</td>
      <td>Half padding, no strides</td>
      <td>Full padding, no strides</td>
    </tr>
    <tr>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/no_padding_strides.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/padding_strides.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/padding_strides_odd.gif"></td>
      <td></td>
    </tr>
    <tr>
      <td>No padding, strides</td>
      <td>Padding, strides</td>
      <td>Padding, strides (odd)</td>
      <td></td>
    </tr>
  </table>

  <h2 id="transposed-convolution-animations">Transposed convolution animations</h2>

  <p><em>N.B.: Blue maps are inputs, and cyan maps are outputs.</em></p>

  <table style="width:100%; table-layout:fixed;">
    <tr>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/no_padding_no_strides_transposed.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/arbitrary_padding_no_strides_transposed.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/same_padding_no_strides_transposed.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/full_padding_no_strides_transposed.gif"></td>
    </tr>
    <tr>
      <td>No padding, no strides, transposed</td>
      <td>Arbitrary padding, no strides, transposed</td>
      <td>Half padding, no strides, transposed</td>
      <td>Full padding, no strides, transposed</td>
    </tr>
    <tr>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/no_padding_strides_transposed.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/padding_strides_transposed.gif"></td>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/padding_strides_odd_transposed.gif"></td>
      <td></td>
    </tr>
    <tr>
      <td>No padding, strides, transposed</td>
      <td>Padding, strides, transposed</td>
      <td>Padding, strides, transposed (odd)</td>
      <td></td>
    </tr>
  </table>

  <h2 id="dilated-convolution-animations">Dilated convolution animations</h2>

  <p><em>N.B.: Blue maps are inputs, and cyan maps are outputs.</em></p>

  <table style="width:25%" ; table-layout:fixed;>
    <tr>
      <td><img width="150px" src="https://raw.githubusercontent.com/vdumoulin/conv_arithmetic/master/gif/dilation.gif"></td>
    </tr>
    <tr>
      <td>No padding, no stride, dilation</td>
    </tr>
  </table>
</div>
