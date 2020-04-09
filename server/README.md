# Server

## Building and Deploying

*Note:* The deployment scripts run the build automatically.

### Build Only

    $ gradle build

### Run the Server Locally

    $ ./bin/run-dev-server.sh

Then open [http://localhost:8080/]().

### Deploy to Staging

    $ ./bin/deploy-staging.sh
    
Then open [https://who-app-staging.appspot.com/]().

### Deploy to Production

    $ ./bin/deploy-production.sh

Then open [https://who-app.appspot.com/]().

## First Time Setup

### Install Homebrew

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

### Install Java

Note: We run on Java 12 but target Java 8.

    $ brew tap adoptopenjdk/openjdk
    $ brew cask install adoptopenjdk12

### Install Gradle

    $ brew install gradle

### Install Google Cloud SDK

Follow the directions [here](https://cloud.google.com/sdk/?hl=en_US).

### Log In

    $ gcloud auth login
    
### Install the most up-to-date App Engine Component

    $  gcloud components install app-engine-java && gcloud components update

### Install IntelliJ IDE (Optional)

    $ brew cask install intellij-idea-ce
    
Open the project in IntelliJ:
    
    $ open -a /Applications/IntelliJ\ IDEA\ CE.app/ .
