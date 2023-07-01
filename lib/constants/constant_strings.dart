class Constant {
  static Url urls = Url();
  static SharedPrefsKeys prefsKeys = SharedPrefsKeys();
  static Titles titles = const Titles();
  static PhoneValidationStatus phoneValidationStatus =
      const PhoneValidationStatus();
  static PasswordValidationStatus passwordValidationStatus =
      const PasswordValidationStatus();
  static ReEnterPasswordValidationStatus reEnterPasswordValidationStatus =
      const ReEnterPasswordValidationStatus();
  static EmailValidationStatus emailValidationStatus =
      const EmailValidationStatus();
  static Fonts fonts = const Fonts();
}

class Titles{
  const Titles();
  //registration
   String get register => 'Register';
   String get login => 'Login';
   String get email => 'Email';
   String get enterEmail => 'Please enter your email';
   String get password => 'Password';
   String get enterPassword => 'Please enter your password';
   String get reEnterPassword => 'Re-enter Password';
   String get plzReEnterPassword => 'Please re-enter your password';
   String get firstName => 'First Name';
   String get enterFirstName => 'Please enter your first name';
   String get lastName => 'Last Name';
   String get enterLastName => 'Please enter your last name';
   String get phoneNumber => 'Phone Number';
   String get enterPhoneNumber => 'Please enter your phone number';
   String get registerSubHeader => 'Enter your data to create a new account';
   String get loginSubHeader => 'To have access to wonderful wallpapers';
   String get notConnected => 'You are offline';
   String get firstNameEmpty => 'First name can not be empty';
   String get lastNameEmpty => 'Last name can not be empty';
}

class PhoneValidationStatus{
  const PhoneValidationStatus();
   String get isEmpty => 'Please enter your phone number';
   String get isNotNumber => 'Please enter valid US number';
   String get isValid => 'Valid';
}

class PasswordValidationStatus {
  const PasswordValidationStatus();
  String get isEmpty => 'Please enter your phone number';
  String get isValid => 'Valid';
}

class EmailValidationStatus {
  const EmailValidationStatus();
  String get isNotValid => 'Please enter a valid email';
  String get isValid => 'Valid';
}

class ReEnterPasswordValidationStatus {
  const ReEnterPasswordValidationStatus();
  String get isEmpty => 'Please re-enter your password';
  String get isNotMatching => 'Passwords doesn\'t match';
  String get isValid => 'Valid';
}

class Fonts{
  const Fonts();
  String get nexa => 'Nexa';
  String get nexaBold => 'NexaBold';
  String get nexaRegular => 'NexaRegular';
}

class Url{}
class SharedPrefsKeys{}