# Telnyx IVR Example

## How it works?

Before setting up, it's better to understand how this application works. The main purpose is to execute a serie of commands that a normal IVR would do. Bellow you can find the implemented steps and the sequence that they will happen.

1. Receive a `Call Initiated` event. Every time we receive a call to one number binded to a call control connection, we are going to receive this event.
2. Issue an `Answer call` command. This command will say to call control that we want to answer the received call.
3. Receive a `Call Answered` event. Every time a call is answered, call control will send us this event.
4. Issue a `Play audio URL` command. Since the call was successfully answered, this command will say to call control to play our IVR options to the caller.
5. Caller press a digit.
6. Receive a `DTMF` event containing the pressed digit. We are going to receive this event every time the caller press a digit during the call.
7. Act accordingly the desired option
	* if digit is `1` then the call is transfered to our imaginary support number
	* if digit is `2` then we hangup the call
	* any other digit we are going back to `step 4` again

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc.

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Configuration
To be able to make requests to the Telnyx's API the following environment variables must be present. You can find these credential in the Telnyx Portal on the Auth section.

```
TELNYX_API_URL=https://api.telnyx.com
TELNYX_API_KEY=my-telnyx-access-key
TELNYX_API_SECRET=my-telnyx-token
```

This project also rely on two more variables. First one is `VOICE_TRACK_URL` that needs to point to a `.wav` or `.mp3` audio with the IVR instructions to be played when the call is answered.

The second one is `SUPPORT_PHONE_NUMBER` which will the number of our imaginary support sector. If the caller decides to talk with the support, the call will be transfered to the number.

```
VOICE_TRACK_URL=https://9999999.ngrok.io/audios/ivr
SUPPORT_PHONE_NUMBER=+19999999999
```

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    % ./bin/deploy staging
    % ./bin/deploy production
