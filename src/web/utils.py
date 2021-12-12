from .models import *

def getPersonAttrs(person):
    contacts = Contact.objects.filter(person=person)
    contacts = [[str(contact.getType()), str(contact.getValue())] for contact in contacts.all()]

    addresses = PersonHasAddress.objects.filter(person=person).select_related()
    addresses = [[str(qSet.address_type), str(qSet.address)] for qSet in addresses.all()]

    roles = PersonHasRole.objects.filter(person=person).select_related()
    roles = [str(qSet.role.role_type) for qSet in roles.all()]

    faculties = FacultyHasPerson.objects.filter(person=person).select_related()
    faculties = [str(qSet.faculty.name) for qSet in faculties.all()]

    departments = DepartmentHasPerson.objects.filter(person=person).select_related()
    departments = [str(qSet.department.name) for qSet in departments.all()]

    programmes = ProgramHasPerson.objects.filter(person=person).select_related()
    programmes = [str(qSet.program.name) for qSet in programmes.all()]

    subjects = PersonHasSubject.objects.filter(person=person).select_related()
    subjects = [str(qSet.subject.name) for qSet in subjects.all()]

    try: # TODO Logging
        thesis = Thesis.objects.get(person=person)
    except:
        thesis = None

    attrs = {
        'person': {
            'Id': person.getId(),
            'Name': person.getName(),
            'Surname': person.getSurname(),
            'Birthdate': person.getBirthdate(),
            'Email': person.getEmail(),
            'Passwd': person.getPasswd(),
            'Note': person.getNote()
        },
        'addresses': addresses,
        'contacts': contacts,
        'roles': roles,
        'faculties': faculties,
        'departments': departments,
        'programmes': programmes,
        'subjects': subjects,
        'thesis': thesis
    }

    return attrs

def sessionCheck(request):
    if request.session.has_key('usr_info'):
        usr_info = request.session['usr_info']
        if 'sysadmin' in usr_info[2]:
            return (True, True)
        else:
            return (True, False)
    return (False, False)