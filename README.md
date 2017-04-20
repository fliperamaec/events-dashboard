Fliperama's events dashboard created with http://shopify.github.com/dashing.

# Configuration

```
cp .env.development .env
```

Update `.env` file with your credentials.

# Starting application

```shell
dashing start
```

# Raspberry Configuration

## Using Epiphany

Install dependencies:

```shell
sudo apt-get update
sudo apt-get install matchbox-window-manager
```

Configure Raspberry by running `sudo raspi-config` and setting boot option to B2 ("command prompt with auto login"). Create a `init.sh` file at `/home/pi` with:

```shell
xset -dpms
xset s off
xset s noblank
matchbox-window-manager -use_titlebar no &
WEBKIT_DISABLE_TBS=1 epiphany-browser -a --profile /home/pi/.config  http://localhost
```

Now edit `/etc/rc.local` and add the following line before `exit 0`:

```shell
sudo xinit ./home/pi/init.sh &
```

## Using Chromium

Create/edit `/etc/xdg/lxsession/LXDE-pi/autostart` script:

```shell
@xset s off
@xset -dpms
@xset s noblank
@chromium-browser --incognito --kiosk http://localhost
```
