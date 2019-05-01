# Regan's notes on the challenge

- I did the ruby/backend edition of this challenge.
- I did the challenge in two parts:
  - The first was to simply generate an ical string using the dummy api supplied. The code for this can be seen on the branch `feature/absences`.
  - The second was to create a rails app so that I could run a server and download the file by visiting `localhost:3000/`, and to add filter options via params to this request. The code for this was on branch `feature/web-interface` and has been merged into `master`.
- I made a set of tests for `absences.rb`, and a second set of request specs for the request to download the file. You can run these tests with: `rspec`
- You can test manually by running `rails s` and trying the following urls:
  - http://localhost:3000/ (all absences)
  - http://localhost:3000/?userId=2664 (all absences for specified user)
  - http://localhost:3000/?startDate=2017-02-14&endDate=2017-03-16 (all absences for specified timeframe)
- The rails app is mostly boilerplate code, the main files to check are:
  - `ruby_edition/cm_challenge/absences.rb`
  - `ruby_edition/app/controllers/absences_controller.rb`
  - `ruby_edition/spec/absences_spec.rb`
  - `ruby_edition/spec/requests/absences_ical_spec.rb`
- I did all the bonus tasks except for the last (making a js version).

If you have any further requests, or if I have misinterpreted the instructions, let me know!

Cheers,
Regan

--------

# Crewmeister coding challenge

Hello and thanks in participating in the crewmeister coding challenge. This
coding exercise will help us get a better feeling about your coding process.

If you have any questions, we're happy to help you. Just drop us an
email: dev+coding-challenge@crewmeister.com

# Instructions

Clone this repository and don't create a fork, so that other candidates
can't copy your solution. The repository contains a scaffold for frontend
and backend candidates including a test setup and a mocked API. You're
free to use whatever tools you want to use. (eg. if you're more comfortable
with a different assertion library feel free to add it).

Whenever you're done please zip the project and send it to:
dev+coding-challenge@crewmeister.com

We'll review your submission as soon as possible. Key-points we're going
to review:

- naming
- tests
- duplications
- code consistency
- function lengths
- commits + commit messages

# Scenario

At crewmeister one of our products is the absence manager. With this product
company owners can manage sickness and vacations of employees. Some of our
customers want to export their employees absences to outlook. To make our
customers happy we decided to provide an iCal export.
https://en.wikipedia.org/wiki/ICalendar

## User Story

As owner of a crew I want to be able to export my employees absences so
that I can import them into outlook.

## Acceptance Criteria

- I can get a list of absences including the names of the employee (using api.js or api.rb)
- I can generate an iCal file and import it into outlook (maybe use a gem or npm package)
- I can see vacations of my employees as "#{member.name} is on vacation"
- I can see sickness of my employees as "#{member.name} is sick"
- (Bonus) I can go to http://localhost:3000 and download the iCal file
- (Bonus) I can go to http://localhost:3000?userId=123 and only receive the absences of the given user
- (Bonus) I can go to http://localhost:3000?startDate=2017-01-01&endDate=2017-02-01 and only receive the absences in the given date range
- (Bonus) Build the first 4 acceptance criteria in the other language (for backend candidates in js and for frontend candidates in ruby)
