# skale-delegations-notificationbot
This simple script check delegations statuses of SKALE validator and notifies the Telegram Bot if we have new proposed delegations.

### Prerequisites

* curl
```
sudo apt-get install curl
```
### Installing

```sh
git clone https://github.com/everstake/skale-delegations-notificationbot.git
cd skale-delegations-notificationbot
chmod +x skale_delegations_check.sh
```
### Configuration

Edit configuration file `skale_delegations_bot.ini`.

## Running
Run a command
```sh
./skale_delegations_check.sh
```
