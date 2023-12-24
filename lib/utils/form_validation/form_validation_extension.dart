extension EmailValidator on String {
  String? isValidEmail(String? value) {
    bool valid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value!);
    if (!valid) {
      return "Please enter valid email";
    }
    return null;
  }

  oldPasswordValid(String? value) {
    if (value!.isEmpty && value.length <= 6) {
      return "Please old password";
    }
    // if (value.length <= 6) {
    //   return "AppFormMessage.passwordValidatCountMessage";
    // }
    return null;
  }

  String? isMemberIdValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter memberID";
    }
    return null;
  }

  String? isValidName(String? value) {
    if (value!.isEmpty) {
      return 'Full Name field cannot be empty';
    }

    final nameRegExp = RegExp(r'^[A-Za-z]+(?:\s[A-Za-z]+)*$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null;
  }

  String? iswordNumberValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter ward number";
    }
    return null;
  }

  String? isFirtNameValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter first name";
    }
    return null;
  }

  String? isLastNameValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter last name";
    }
    return null;
  }

  String? isfeedBackValidate(String? value) {
    if (value!.isEmpty) {
      return "Please enter feedback name";
    }
    return null;
  }

  String? isWordNumber(String? value) {
    if (value!.isEmpty) {
      return "Please enter ward number";
    }
    return null;
  }

  String? isAddressValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter location";
    }
    return null;
  }

  String? isMeetValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter meeting location";
    }
    return null;
  }

  String? isPasswordValid(String? value) {
    if (value!.isEmpty) {
      return 'Password field cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()]'))) {
      return 'Password must contain at least one special character (!@#%^&*())';
    }
    // Add any additional password validation logic here
    return null;
  }

  String? iscodeValidated(String? value) {
    if (value!.length < 6) {
      return "Please enter 6 digits code";
    }
    return null;
  }

  String? isPhoneValidate(String? value) {
    if (value!.isEmpty) {
      return 'Phone Number field cannot be empty';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? isAgeValidate(String? value) {
    if (value!.isEmpty) {
      return 'Age field cannot be empty';
    }
    if (int.tryParse(value) == null) {
      return 'Age must be a valid number';
    }
    final age = int.parse(value);
    if (age < 6 || age > 100) {
      return 'Age must be between 6 and 100';
    }
    return null;
  }

  String? isDOBValidate(String? value) {
    if (value!.isEmpty) {
      return "Please enter your date of birth";
    }
    return null;
  }

  String? isDepartDOB(String? value) {
    if (value!.isEmpty) {
      return "Please enter your departure date";
    }
    return null;
  }

  String? isTokenValidate(String? value) {
    if (value!.isEmpty) {
      return "Please enter your token";
    }
    return null;
  }

  String? isGenderValidate(String? value) {
    if (value!.isEmpty) {
      return "Please select your gender";
    }
    return null;
  }

  String? isVehicleNameValidate(String? value) {
    if (value!.isEmpty) {
      return 'Vehicle Name field cannot be empty';
    }

    final nameRegExp = RegExp(r'^[A-Za-z]+(?:\s[A-Za-z]+)*$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Please enter a valid vehicle name';
    }

    return null;
  }

  String? isVehicleTypeValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a vehicle';
    }
    return null;
  }

  String? isVehicleNumberValidate(String? value) {
    if (value!.isEmpty) {
      return 'Vehicle Number field cannot be empty';
    }
    // Add additional validation logic if needed
    final pattern = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9]+$');
    if (!pattern.hasMatch(value)) {
      return 'Please enter a valid vehicle number';
    }
    return null;
  }

  String? isVehicleFacilityValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a vehicle facility';
    }
    return null;
  }

  String? isDepartingTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a departing time';
    }
    return null;
  }

  String? isArrivingTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an arriving time';
    }
    return null;
  }

  String? isPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Seat Price field cannot be empty';
    }
    if (int.tryParse(value) == null) {
      return 'Seat Price must be a valid number';
    }
    final age = int.parse(value);
    if (age <= 100) {
      return 'Seat Price must be over or equals to 100';
    }
    return null;
  }

  String? isVehicleSeatsValidate(String? value) {
    if (value!.isEmpty) {
      return 'Vehicle Seats field cannot be empty';
    }
    if (int.tryParse(value) == null) {
      return 'Vehicle Seats must be a valid number';
    }
    final age = int.parse(value);
    if (age < 1 || age > 50) {
      return 'Vehicle Seats must be between 1 and 50';
    }
    return null;
  }

  confirmPasswordValidation(String? val, String oldPassword) {
    if (val!.isEmpty) return 'Please enter password of atleast 6 characters';
    if (val != oldPassword) return 'Password did not match';
    return null;
  }
}
