"""Configuration settings for PPP package."""

from jinja2 import Environment, PackageLoader


TEMPLATE_ENV = Environment(loader=PackageLoader('pmix.ppp'), trim_blocks=True,
                           lstrip_blocks=True)
