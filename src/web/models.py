# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Address(models.Model):
    address_id = models.AutoField(primary_key=True)
    state = models.CharField(max_length=50)
    city = models.CharField(max_length=50)
    street = models.CharField(max_length=50)
    house_number = models.IntegerField()
    postal_code = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'address'

    def __str__(self):
        return f"{self.state}, {self.city}, {self.street}, {self.house_number}, {self.postal_code}"


class Contact(models.Model):
    contact_id = models.AutoField(primary_key=True)
    person = models.ForeignKey('Person', models.DO_NOTHING)
    contact_type = models.CharField(max_length=20)
    value = models.CharField(max_length=50)
    last_change = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'contact'

    def __str__(self):
        return f"{self.contact_type}, {self.value}"

    def getType(self):
        return self.contact_type

    def getValue(self):
        return self.value


class Department(models.Model):
    department_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    decription = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'department'

    def getAll():
        return [str(qSet.name) for qSet in Department.objects.all()]

class DepartmentHasPerson(models.Model):
    department = models.ForeignKey(Department, models.DO_NOTHING)
    person = models.ForeignKey('Person', on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'department_has_person'


class DepartmentHasProgram(models.Model):
    department = models.ForeignKey(Department, models.DO_NOTHING)
    program = models.ForeignKey('StudyProgram', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'department_has_program'


class Faculty(models.Model):
    faculty_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    address = models.ForeignKey(Address, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'faculty'

    def getAll():
        return [str(qSet.name) for qSet in Faculty.objects.all()]


class FacultyHasDepartment(models.Model):
    faculty = models.ForeignKey(Faculty, models.DO_NOTHING)
    department = models.ForeignKey(Department, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'faculty_has_department'


class FacultyHasPerson(models.Model):
    faculty = models.ForeignKey(Faculty, models.DO_NOTHING)
    person = models.ForeignKey('Person', on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'faculty_has_person'


class Person(models.Model):
    person_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=20)
    surname = models.CharField(max_length=20)
    birthdate = models.DateField()
    email = models.CharField(max_length=50)
    passwd = models.CharField(max_length=255)
    additional_note = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'person'

    def getId(self):
        return self.person_id

    def getName(self):
        return self.name

    def getSurname(self):
        return self.surname

    def getBirthdate(self):
        return self.birthdate

    def getEmail(self):
        return self.email

    def getPasswd(self):
        return self.passwd
    
    def getNote(self):
        return self.additional_note


class PersonHasAddress(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    address = models.ForeignKey(Address, models.DO_NOTHING)
    address_type = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'person_has_address'


class PersonHasRole(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    role = models.ForeignKey('Role', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'person_has_role'
    
    def __str__(self):
        return f"{self.person} {self.role}"


class PersonHasSubject(models.Model):
    person = models.ForeignKey(Person, on_delete=models.CASCADE)
    subject = models.ForeignKey('Subject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'person_has_subject'


class ProgramHasPerson(models.Model):
    program = models.ForeignKey('StudyProgram', models.DO_NOTHING)
    person = models.ForeignKey(Person, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'program_has_person'


class ProgramHasSubject(models.Model):
    program = models.ForeignKey('StudyProgram', models.DO_NOTHING)
    subject = models.ForeignKey('Subject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'program_has_subject'


class Role(models.Model):
    role_id = models.AutoField(primary_key=True)
    role_type = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'role'

    def __str__(self):
        return self.role_type

    def getAll():
        return [str(qSet.role_type) for qSet in Role.objects.all()]


class StudyProgram(models.Model):
    program_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    description = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'study_program'

    def getAll():
        return [str(qSet.name) for qSet in StudyProgram.objects.all()]

class Subject(models.Model):
    subject_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    department = models.ForeignKey(Department, models.DO_NOTHING)
    description = models.CharField(max_length=255, blank=True, null=True)
    prerequisites = models.CharField(max_length=255, blank=True, null=True)
    semester = models.SmallIntegerField()
    review = models.SmallIntegerField(blank=True, null=True)
    additional_info = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'subject'

    def getAll():
        return [str(qSet.name) for qSet in Subject.objects.all()]


class Thesis(models.Model):
    thesis_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    thesis_type = models.CharField(max_length=20)
    description = models.CharField(max_length=255, blank=True, null=True)
    person = models.ForeignKey(Person, on_delete=models.CASCADE)

    class Meta:
        managed = False
        db_table = 'thesis'

    def __str__(self):
        return self.name
