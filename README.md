# Telnyx IVR Example

## How it works?

This application demonstrates a simple interactive voice response (IVR) system,
built using the call control features of Telnyx's API. Call control is
essentially a collection of commands triggered by your application and events
that occur on the call as a result of actions of the caller or callee or of a
command.

This IVR represents a flow with which we are all familiar: the customer places
a call to a company which is immediately answered and an audio menu is played to
the caller allowing them to select the department they need from a list.

Using call control that flow looks like:

1. Receive a `Call Initiated` event. This will occur when we receive a call
to a number associated with a call control connection.
2. Issue an `Answer Call` command, instructing call control to answer the
call.
3. Receive a `Call Answered` event, verifying the call has been answered.
4. Issue a `Gather` command, playing our audio menu to the caller and
instructing them to select an option by pressing a digit.
5. Caller press a digit.
6. Receive a `Gather Ended` event containing the pressed digit.
7. Perform an action based on the digit pressed by the caller:
	* if the digit is `1`, the call is transfered to our imaginary support number
	* if the digit is `2`, hangup the call
	* if any other digit is pressed, return to `step 4` and replay the audio menu.

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc.

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Configuration
In order to use the Telnyx API the following environment variables must be
present. You can find these credential in the Telnyx Portal
under the Auth section.

```
TELNYX_API_KEY=my-telnyx-access-key
TELNYX_API_SECRET=my-telnyx-token
```

You also need to set the `SUPPORT_PHONE_NUMBER` environment variable which will
be the number of the support department in the IVR. If the caller selects the
support option from the audio menu, the call will be transfered to this number.

You may also specify a custom file for the audio menu by setting the
`IVR_MENU_URL` environment variable. This url must point to a publicly
accessible audio file of either `.wav` or `.mp3` format.

### Example

```
IVR_MENU_URL=https://9999999.ngrok.io/files/ivr_menu
SUPPORT_PHONE_NUMBER=+19999999999
```

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    % ./bin/deploy staging
    % ./bin/deploy production
