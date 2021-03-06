from django import template
from ..models import Person
from .. import utils

register = template.Library()

@register.simple_tag
def getUsrId(person_attrs):
    return person_attrs.get('person').get('Id')

@register.simple_tag
def getUsrRoles(person_attrs):
    return person_attrs.get('roles')

@register.simple_tag
def getUsrFacs(person_attrs):
    return person_attrs.get('faculties')

@register.simple_tag
def getUsrDeps(person_attrs):
    return person_attrs.get('departments')

@register.simple_tag
def getUsrProgs(person_attrs):
    return person_attrs.get('programs')

@register.simple_tag
def getUsrSubjs(person_attrs):
    return person_attrs.get('subjects')