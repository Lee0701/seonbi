
const fs = require('fs')

const exceptions = {
    庫間: "곳간",
    貰房: "셋방",
    數字: "숫자",
    車間: "찻간",
    退間: "툇간",
    回數: "횟수",
}

const content = fs.readFileSync('hanja.txt', 'utf8')
const comments = content.split('\n').filter((line) => line.startsWith('#'))
const entries = content.split('\n').filter((line) => !line.startsWith('#')).map((line) => line.trim().split(':')).filter((entry) => entry && entry.length == 3)

const chars = entries.filter(([_reading, hanja]) => hanja.length == 1)
const words = entries.filter(([_reading, hanja]) => hanja.length > 1)

const charReadingMap = chars.reduce((acc, [reading, hanja]) => {
    acc[hanja] = [...(acc[hanja] || []), reading]
    return acc
}, {})

const legalWords = words.filter(([reading, hanja]) => {
    if(exceptions[hanja]) return exceptions[hanja] == reading
    const legalCount = hanja.split('').filter((h, i) => {
        const r = reading.charAt(i)
        if(r == h) return true
        return charReadingMap[h] && charReadingMap[h].includes(r)
    }).length
    return hanja.length == legalCount
})

const output = legalWords.map(([reading, hanja]) => `${hanja}\t${reading}`).join('\n')

fs.writeFileSync('hanja-legal.tsv', output)
fs.writeFileSync('comment.txt', comments.join('\n'))
