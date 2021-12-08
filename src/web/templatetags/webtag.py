from django import template

register = template.Library()

@register.simple_tag
def usrId(person_attrs):
    return person_attrs.get('person').get('Id')