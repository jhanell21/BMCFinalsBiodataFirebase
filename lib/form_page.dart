import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BioDataPage extends StatefulWidget {
  const BioDataPage({super.key});

  @override
  State<BioDataPage> createState() => _BioDataPageState();
}

class _BioDataPageState extends State<BioDataPage> {
  // ==============================
  // PERSONAL DATA
  // ==============================

  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final currentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

  // ==============================
  // PERSONAL INFORMATION
  // ==============================

  final ageController = TextEditingController();
  final occupationController = TextEditingController();
  final civilStatusController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();

  // ==============================
  // LANGUAGE
  // ==============================

  final languageController = TextEditingController();

  // ==============================
  // EMERGENCY CONTACT
  // ==============================

  final emergencyNameController = TextEditingController();
  final emergencyAddressController = TextEditingController();
  final emergencyContactController = TextEditingController();

  // ==============================
  // OTHER INFORMATION
  // ==============================

  final cellphoneController = TextEditingController();
  final emailController = TextEditingController();
  final citizenshipController = TextEditingController();
  final religionController = TextEditingController();

  // ==============================
  // EDUCATIONAL BACKGROUND
  // ==============================

  final elementarySchoolController = TextEditingController();
  final elementaryYearController = TextEditingController();

  final highSchoolController = TextEditingController();
  final highSchoolYearController = TextEditingController();

  final collegeController = TextEditingController();
  final collegeYearController = TextEditingController();

  bool isSaving = false;

  // ==============================
  // DISPOSE
  // ==============================

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    dobController.dispose();
    currentAddressController.dispose();
    permanentAddressController.dispose();

    ageController.dispose();
    occupationController.dispose();
    civilStatusController.dispose();
    placeOfBirthController.dispose();
    heightController.dispose();
    weightController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();

    languageController.dispose();

    emergencyNameController.dispose();
    emergencyAddressController.dispose();
    emergencyContactController.dispose();

    cellphoneController.dispose();
    emailController.dispose();
    citizenshipController.dispose();
    religionController.dispose();

    elementarySchoolController.dispose();
    elementaryYearController.dispose();

    highSchoolController.dispose();
    highSchoolYearController.dispose();

    collegeController.dispose();
    collegeYearController.dispose();

    super.dispose();
  }

  // ==============================
  // CLEAR FORM
  // ==============================

  void clearForm() {
    final controllers = [
      nameController,
      genderController,
      dobController,
      currentAddressController,
      permanentAddressController,
      ageController,
      occupationController,
      civilStatusController,
      placeOfBirthController,
      heightController,
      weightController,
      fatherNameController,
      motherNameController,
      languageController,
      emergencyNameController,
      emergencyAddressController,
      emergencyContactController,
      cellphoneController,
      emailController,
      citizenshipController,
      religionController,
      elementarySchoolController,
      elementaryYearController,
      highSchoolController,
      highSchoolYearController,
      collegeController,
      collegeYearController,
    ];

    for (final controller in controllers) {
      controller.clear();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form cleared.'),
      ),
    );
  }

  // ==============================
  // SUBMIT TO FIRESTORE
  // ==============================

  Future<void> submitForm() async {
    // Basic validation
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name.'),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('biodata')
          .add({
        // PERSONAL DATA
        'name': nameController.text.trim(),
        'gender': genderController.text.trim(),
        'dateOfBirth': dobController.text.trim(),
        'currentAddress': currentAddressController.text.trim(),
        'permanentAddress': permanentAddressController.text.trim(),

        // PERSONAL INFORMATION
        'age': ageController.text.trim(),
        'occupation': occupationController.text.trim(),
        'civilStatus': civilStatusController.text.trim(),
        'placeOfBirth': placeOfBirthController.text.trim(),
        'height': heightController.text.trim(),
        'weight': weightController.text.trim(),
        'fatherName': fatherNameController.text.trim(),
        'motherName': motherNameController.text.trim(),

        // LANGUAGE
        'language': languageController.text.trim(),

        // EMERGENCY CONTACT
        'emergencyName': emergencyNameController.text.trim(),
        'emergencyAddress': emergencyAddressController.text.trim(),
        'emergencyContact': emergencyContactController.text.trim(),

        // OTHER INFORMATION
        'cellphone': cellphoneController.text.trim(),
        'email': emailController.text.trim(),
        'citizenship': citizenshipController.text.trim(),
        'religion': religionController.text.trim(),

        // EDUCATIONAL BACKGROUND
        'elementarySchool':
            elementarySchoolController.text.trim(),
        'elementaryYear':
            elementaryYearController.text.trim(),

        'highSchool':
            highSchoolController.text.trim(),
        'highSchoolYear':
            highSchoolYearController.text.trim(),

        'college':
            collegeController.text.trim(),
        'collegeYear':
            collegeYearController.text.trim(),

        // DATE SAVED
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bio-data saved successfully to Firebase!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving bio-data: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  // ==============================
  // BUILD
  // ==============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 750,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  // ==============================
                  // HEADER
                  // ==============================

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'BIO-DATA',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // PHOTO
                      Container(
                        width: 120,
                        height: 135,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),

                        clipBehavior:
                            Clip.antiAlias,

                        child: Image.asset(
                          'assets/images/profile.jpeg',
                          fit: BoxFit.cover,

                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const Center(
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ==============================
                  // PERSONAL DATA
                  // ==============================

                  sectionTitle('PERSONAL DATA'),

                  const SizedBox(height: 8),

                  bioInput(
                    'Name',
                    nameController,
                  ),

                  bioInput(
                    'Gender',
                    genderController,
                  ),

                  bioInput(
                    'Date of Birth',
                    dobController,
                  ),

                  bioInput(
                    'Current Address',
                    currentAddressController,
                  ),

                  bioInput(
                    'Permanent Address',
                    permanentAddressController,
                  ),

                  const SizedBox(height: 15),

                  // ==============================
                  // PERSONAL INFORMATION
                  // ==============================

                  sectionTitle(
                    'PERSONAL INFORMATION',
                  ),

                  const SizedBox(height: 8),

                  bioInput(
                    'Age',
                    ageController,
                    keyboardType:
                        TextInputType.number,
                  ),

                  bioInput(
                    'Occupation',
                    occupationController,
                  ),

                  bioInput(
                    'Civil Status',
                    civilStatusController,
                  ),

                  bioInput(
                    'Place of Birth',
                    placeOfBirthController,
                  ),

                  bioInput(
                    'Height',
                    heightController,
                  ),

                  bioInput(
                    'Weight',
                    weightController,
                  ),

                  bioInput(
                    "Father's Name",
                    fatherNameController,
                  ),

                  bioInput(
                    "Mother's Name",
                    motherNameController,
                  ),

                  const SizedBox(height: 15),

                  // ==============================
                  // LANGUAGE
                  // ==============================

                  sectionTitle('LANGUAGE'),

                  const SizedBox(height: 8),

                  bioInput(
                    'Language or dialect spoken',
                    languageController,
                  ),

                  const SizedBox(height: 15),

                  // ==============================
                  // EMERGENCY CONTACT
                  // ==============================

                  sectionTitle(
                    'EMERGENCY CONTACT',
                  ),

                  const SizedBox(height: 8),

                  bioInput(
                    'Person to be contacted in case of emergency',
                    emergencyNameController,
                  ),

                  bioInput(
                    'Address',
                    emergencyAddressController,
                  ),

                  bioInput(
                    'Contact No',
                    emergencyContactController,
                    keyboardType:
                        TextInputType.phone,
                  ),

                  const SizedBox(height: 15),

                  // ==============================
                  // OTHER INFORMATION
                  // ==============================

                  sectionTitle(
                    'OTHER INFORMATION',
                  ),

                  const SizedBox(height: 8),

                  bioInput(
                    'Cellphone',
                    cellphoneController,
                    keyboardType:
                        TextInputType.phone,
                  ),

                  bioInput(
                    'Email',
                    emailController,
                    keyboardType:
                        TextInputType.emailAddress,
                  ),

                  bioInput(
                    'Citizenship',
                    citizenshipController,
                  ),

                  bioInput(
                    'Religion',
                    religionController,
                  ),

                  bioInput(
                    'Occupation',
                    occupationController,
                  ),

                  const SizedBox(height: 20),

                  // ==============================
                  // EDUCATIONAL BACKGROUND
                  // ==============================

                  sectionTitle(
                    'EDUCATIONAL BACKGROUND',
                  ),

                  const SizedBox(height: 10),

                  educationInput(
                    'Elementary',
                    elementarySchoolController,
                    elementaryYearController,
                  ),

                  educationInput(
                    'High School',
                    highSchoolController,
                    highSchoolYearController,
                  ),

                  educationInput(
                    'College',
                    collegeController,
                    collegeYearController,
                  ),

                  const SizedBox(height: 25),

                  // ==============================
                  // BUTTONS
                  // ==============================

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [

                      OutlinedButton(
                        onPressed:
                            isSaving ? null : clearForm,

                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              Colors.black,
                          side:
                              const BorderSide(
                            color: Colors.black,
                          ),
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 25,
                            vertical: 14,
                          ),
                        ),

                        child: const Text(
                          'CLEAR',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed:
                            isSaving
                                ? null
                                : submitForm,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.black,
                          foregroundColor:
                              Colors.white,
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 25,
                            vertical: 14,
                          ),
                        ),

                        child: Text(
                          isSaving
                              ? 'SAVING...'
                              : 'SUBMIT',
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==============================
  // SECTION TITLE
  // ==============================

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ==============================
  // INPUT FIELD
  // ==============================

  Widget bioInput(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // LABEL
          SizedBox(
            width: 210,

            child: Padding(
              padding:
                  const EdgeInsets.only(
                top: 14,
              ),

              child: Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          // INPUT
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,

              decoration:
                  const InputDecoration(
                isDense: true,

                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),

                border:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),

              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================
  // EDUCATION INPUT
  // ==============================

  Widget educationInput(
    String level,
    TextEditingController schoolController,
    TextEditingController yearController,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          // LEVEL
          SizedBox(
            width: 100,

            child: Padding(
              padding:
                  const EdgeInsets.only(
                top: 14,
              ),

              child: Text(
                '$level:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          // SCHOOL
          Expanded(
            child: TextField(
              controller:
                  schoolController,

              decoration:
                  const InputDecoration(
                hintText: 'School name',
                isDense: true,

                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),

                border:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),

              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // YEAR
          SizedBox(
            width: 130,

            child: TextField(
              controller:
                  yearController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                hintText: 'Year',
                isDense: true,

                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),

                border:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderSide:
                      BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),

              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
