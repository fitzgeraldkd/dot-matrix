![Dot Matrix](https://i.imgur.com/cIJCDcv.png)

# Dot Matrix Animator

## Setup

Note that this project utilizes the RMagick gem, which has some pre-requisites. Please follow the instructions in [RMagick's README](https://github.com/rmagick/rmagick#prerequisites) to get these setup. This project currently uses RMagick version 4.2.

Once the prerequisites are taken care of, run `bundle install` in your terminal to install the required gems.

## Running

This project uses the Thor gem to implement a command line interface. In the CLI, you can use `bin/run` to see a list of available commands.

> If `bin/run` is not working, try using `ruby bin/run` instead.

```bash
$ bin/run 

Commands:
  run help [COMMAND]  # Describe available commands or one specific command
  run render_gif      # Render a GIF
```

To get more info on a command, use `help` and you should get a longer description of the command as well as a list of all of its options.

```bash
$ bin/run help render_gif
```

To actually run the scripts, use this command:

```bash
$ bin/run render_gif
```

There are a number of options for running this command as well, and they can be overwritten like so:

```bash
$ bin/run render_gif --subfolder=demo --columns=32 --rows=10 --bg_color=chocolate --fg_color="mint cream" --fps=10 --dot_size=10
```

The any of the options can be left blank. To see the default values, run the `help` command and it will display a list of options, what each option's purpose is, and the default value.

## Demo

In the repo there's a folder, `./assets/demo`, that has some sample images. These images act as the keyframes in the animation:

![Dot matrix keyframes](https://i.imgur.com/6WDhHC0.png)

After running `bin/run render_gif --subfolder=demo`, you should see something like this added to the `./output` folder:

![Dot matrix animation](https://i.imgur.com/zEfihJk.gif)

## Resources

For a list of acceptable color names for the `bg_color` and `fg_color` options, take a look at [this page](https://rmagick.github.io/imusage.html#color_names) in RMagick's documentation.