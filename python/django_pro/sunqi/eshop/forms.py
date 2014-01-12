from django import forms
#include "/root/test_project/python/pydiction/complete-dict"
class ContactForm(forms.Form):
    subject = forms.CharField()
    email = forms.EmailField()
    message = forms.CharField()

