from django import forms
from .models import Person, Role, PersonHasRole
import bcrypt, uuid

class LoginForm(forms.Form):
    email = forms.CharField(max_length = 100)
    password = forms.CharField(widget = forms.PasswordInput())

    def clean_email(self):
        email = self.cleaned_data.get("email")
        dbuser = Person.objects.filter(email = email)
        if not dbuser:
            raise forms.ValidationError("User does not exist!")
        else:
            return email

    def clean_password(self):
        try:
            email = self.cleaned_data['email']
        except KeyError:
            return
        passwd = self.cleaned_data.get('password').encode('utf-8')
        dbuser = Person.objects.get(email = email)
        dbpass = dbuser.passwd.encode('utf-8')
        if not bcrypt.checkpw(passwd, dbpass):
            raise forms.ValidationError("Wrong password!")
        else:
            phr = PersonHasRole.objects.filter(person=dbuser).select_related()
            self.usr_roles = []
            for role_qs in phr.all():
                self.usr_roles.append(str(role_qs.role.role_type))
            self.usr_id = dbuser.person_id
            self.usr_name = dbuser.name
            return passwd

    def getUserInfo(self):
        return [self.usr_id, self.usr_name, self.usr_roles]

        