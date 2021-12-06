from django.contrib import admin
from .models import *
# Register your models here.
# Person, PersonHasAddress, PersonHasRole, PersonHasSubject
# Faculty, FacultyHasDepartment, FacultyHasPerson 
# Department, DepartmentHasPerson, DepartmentHasProgram
# StudyProgram, ProgramHasPerson, ProgramHasSubject
# Subject, Contact, Address

admin.site.register(Person)
admin.site.register(PersonHasAddress)
admin.site.register(PersonHasRole)
admin.site.register(PersonHasSubject)
admin.site.register(Faculty)
admin.site.register(FacultyHasDepartment)
admin.site.register(FacultyHasPerson)
admin.site.register(Department)
admin.site.register(DepartmentHasProgram)
admin.site.register(DepartmentHasPerson)
admin.site.register(StudyProgram)
admin.site.register(ProgramHasPerson)
admin.site.register(ProgramHasSubject)
admin.site.register(Subject)
admin.site.register(Contact)
admin.site.register(Address)