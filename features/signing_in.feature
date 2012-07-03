Feature: Signing In

Scenario: Unsuccessful Sign In
	Given a user visits signin page
	When he submits invalid signin information
	Then he should see an error message
	
Scenario: Successful Sign In
	Given a user visits signin page
		And the user has an account
		And the user submits valid signin information
		Then he should see his profile page
			And he should see a signout link