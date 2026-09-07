# NHL Oh My Zsh Prompt Themes

This repository contains a collection of Oh My Zsh prompt themes inspired by NHL (National Hockey League) teams. Show your team spirit right in your terminal!

## Overview

Each theme in this collection represents a different NHL team, featuring the team's colors and logo in your zsh prompt. Whether you're a fan of the Maple Leafs, Canadiens, Bruins, or any other NHL team, there's a theme here for you!

## Themes

Rendered with JetBrains Mono Nerd Font on a dark background.

| Team | File | Preview |
|---|---|---|
| Colorado Avalanche | `nhl/avalanche/avalanche-current.zsh-theme` | ![Colorado Avalanche](nhl/previews/avalanche-current.png) |
| Chicago Blackhawks | `nhl/blackhawks/blackhawks-current.zsh-theme` | ![Chicago Blackhawks](nhl/previews/blackhawks-current.png) |
| Columbus Blue Jackets | `nhl/blue-jackets/blue-jackets-current.zsh-theme` | ![Columbus Blue Jackets](nhl/previews/blue-jackets-current.png) |
| St. Louis Blues | `nhl/blues/blues-current.zsh-theme` | ![St. Louis Blues](nhl/previews/blues-current.png) |
| Boston Bruins | `nhl/bruins/bruins-current.zsh-theme` | ![Boston Bruins](nhl/previews/bruins-current.png) |
| Montreal Canadiens | `nhl/canadiens/canadiens-current.zsh-theme` | ![Montreal Canadiens](nhl/previews/canadiens-current.png) |
| Vancouver Canucks | `nhl/canucks/canucks-current.zsh-theme` | ![Vancouver Canucks](nhl/previews/canucks-current.png) |
| 1980s Vancouver Canucks | `nhl/canucks/canucks-retro.zsh-theme` | ![1980s Vancouver Canucks](nhl/previews/canucks-retro.png) |
| Washington Capitals | `nhl/capitals/capitals-current.zsh-theme` | ![Washington Capitals](nhl/previews/capitals-current.png) |
| New Jersey Devils | `nhl/devils/devils-current.zsh-theme` | ![New Jersey Devils](nhl/previews/devils-current.png) |
| Anaheim Ducks | `nhl/ducks/ducks-current.zsh-theme` | ![Anaheim Ducks](nhl/previews/ducks-current.png) |
| Calgary Flames | `nhl/flames/flames-current.zsh-theme` | ![Calgary Flames](nhl/previews/flames-current.png) |
| Calgary Flames | `nhl/flames/flames-retro.zsh-theme` | ![Calgary Flames](nhl/previews/flames-retro.png) |
| Philadelphia Flyers | `nhl/flyers/flyers-current.zsh-theme` | ![Philadelphia Flyers](nhl/previews/flyers-current.png) |
| Vegas Golden Knights | `nhl/golden-knights/golden-knights-current.zsh-theme` | ![Vegas Golden Knights](nhl/previews/golden-knights-current.png) |
| Carolina Hurricanes | `nhl/hurricanes/hurricanes-current.zsh-theme` | ![Carolina Hurricanes](nhl/previews/hurricanes-current.png) |
| New York Islanders | `nhl/islanders/islanders-current.zsh-theme` | ![New York Islanders](nhl/previews/islanders-current.png) |
| Winnipeg Jets | `nhl/jets/jets-current.zsh-theme` | ![Winnipeg Jets](nhl/previews/jets-current.png) |
| LA Kings | `nhl/kings/kings-current.zsh-theme` | ![LA Kings](nhl/previews/kings-current.png) |
| LA Kings Retro | `nhl/kings/kings-retro.zsh-theme` | ![LA Kings Retro](nhl/previews/kings-retro.png) |
| Seattle Kraken | `nhl/kraken/kraken-current.zsh-theme` | ![Seattle Kraken](nhl/previews/kraken-current.png) |
| Tampa Bay Lightning | `nhl/lightning/lightning-current.zsh-theme` | ![Tampa Bay Lightning](nhl/previews/lightning-current.png) |
| Utah Mammoth | `nhl/mammoth/mammoth-current.zsh-theme` | ![Utah Mammoth](nhl/previews/mammoth-current.png) |
| Toronto Maple Leafs | `nhl/maple-leafs/maple-leafs-current.zsh-theme` | ![Toronto Maple Leafs](nhl/previews/maple-leafs-current.png) |
| Edmonton Oilers | `nhl/oilers/oilers-current.zsh-theme` | ![Edmonton Oilers](nhl/previews/oilers-current.png) |
| Edmonton Oilers | `nhl/oilers/oilers-retro.zsh-theme` | ![Edmonton Oilers](nhl/previews/oilers-retro.png) |
| Florida Panthers | `nhl/panthers/panthers-current.zsh-theme` | ![Florida Panthers](nhl/previews/panthers-current.png) |
| Pittsburgh Penguins | `nhl/penguins/penguins-current.zsh-theme` | ![Pittsburgh Penguins](nhl/previews/penguins-current.png) |
| Nashville Predators | `nhl/predators/predators-current.zsh-theme` | ![Nashville Predators](nhl/previews/predators-current.png) |
| New York Rangers | `nhl/rangers/rangers-current.zsh-theme` | ![New York Rangers](nhl/previews/rangers-current.png) |
| Detroit Red Wings | `nhl/red-wings/red-wings-current.zsh-theme` | ![Detroit Red Wings](nhl/previews/red-wings-current.png) |
| Buffalo Sabres | `nhl/sabres/sabres-current.zsh-theme` | ![Buffalo Sabres](nhl/previews/sabres-current.png) |
| Ottawa Senators | `nhl/senators/senators-current.zsh-theme` | ![Ottawa Senators](nhl/previews/senators-current.png) |
| San Jose Sharks | `nhl/sharks/sharks-current.zsh-theme` | ![San Jose Sharks](nhl/previews/sharks-current.png) |
| Dallas Stars | `nhl/stars/stars-current.zsh-theme` | ![Dallas Stars](nhl/previews/stars-current.png) |
| Minnesota Wild | `nhl/wild/wild-current.zsh-theme` | ![Minnesota Wild](nhl/previews/wild-current.png) |

## Installation

To use these themes, you need to have [Oh My Zsh](https://ohmyz.sh/) installed. If you haven't installed it yet, follow the instructions on their website.

### Installing Custom Oh My Zsh Themes

1. Clone this repository:

   ```
   git clone https://github.com/sryanb/ohmyzsh-nhl-themes.git
   ```

2. Copy the theme files to your Oh My Zsh custom themes directory:

   ```
   cp -r ohmyzsh-nhl-themes/nhl/[yourteam]/ ~/.oh-my-zsh/custom/themes/
   ```

3. Open your `~/.zshrc` file in a text editor.

4. Set the `ZSH_THEME` variable to the name of the theme you want to use. For example:

   ```
   ZSH_THEME="oilers/oilers-current"
   ```

5. Save the file and restart your terminal or run:
   ```
   source ~/.zshrc
   ```

## Customization

Feel free to modify the themes to your liking. Each theme file is a zsh script that defines how your prompt looks. You can edit colors, add information, or change the layout.

## Contributing

Contributions are welcome! If you'd like to add a theme for your favorite team or improve an existing one, please submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the [Oh My Zsh](https://ohmyz.sh/) project for making terminal customization fun and easy.
- Inspired by the passion of NHL fans everywhere.

Enjoy your NHL-themed terminal experience!
