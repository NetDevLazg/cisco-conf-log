

def configs_check(difflist):
    """
    Generate a list of files which exist in the bundle image but not the base
    image

    '- ' - line unique to lhs
    '+ ' - line unique to rhs
    '  ' - line common
    '? ' - line not present in either

    returns a list containing the items which are unique in the rhs

    difflist --- a list containing the output of difflib.Differ.compare
          where the lhs (left-hand-side) was the base image and the rhs
          (right-hand-side) was base image + extras (the bundle image).
    """
    cont = []
    for ln in difflist:
        if ln[0] == '+' and len(ln) >= 4:
            cont.append(ln[0:])
        if ln[0] == '-' and len(ln) >= 4:
            cont.append(ln[0:])
    return cont

#    for ln in difflist:
#        if ln[0] == '+':
#            cont.append(ln[0:])
#        if ln[0] == '-':
#            cont.append(ln[0:])
#    return cont