from .fr import STRINGS as _FR
from .en import STRINGS as _EN

_LANGS = {"fr": _FR, "en": _EN}
_current = "fr"


def set_lang(lang: str):
    global _current
    if lang in _LANGS:
        _current = lang


def get_lang() -> str:
    return _current


def t(key: str, **kwargs) -> str:
    val = _LANGS[_current].get(key) or _LANGS["fr"].get(key, key)
    if kwargs and isinstance(val, str):
        try:
            return val.format(**kwargs)
        except (KeyError, ValueError):
            pass
    return val
