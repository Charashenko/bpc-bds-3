from django import forms
from .models import Person
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
            self.usr_name = dbuser.get(email = email).name
            return email

    def clean_password(self):
        try:
            email = self.cleaned_data['email']
        except KeyError:
            return
        passwd = self.cleaned_data.get('password').encode('utf-8')
        dbpass = Person.objects.get(email = email).passwd.encode('utf-8')
        if not bcrypt.checkpw(passwd, dbpass):
            raise forms.ValidationError("Wrong password!")
        else:
            return passwd

    def getUserId(self):
        return [self.usr_name, str(uuid.uuid4())]

        