from os import listdir
import json
import pandas as pd
from datetime import datetime
import matplotlib.pyplot as plt
import re
import matplotlib.dates as mdates

# load json files
locs = listdir('opendata')
files = ['opendata/' + locs[i] for i in range(len(locs))]
locs = list(map(lambda x: re.sub('.json', '', x).capitalize(), locs))
ans = {}
for f in files:
    with open(f) as json_data:
        data = json.load(json_data)
        hourly = pd.DataFrame(data['hourly'])
        time = hourly['dt']
        date = [datetime.utcfromtimestamp(time[i]).strftime('%Y-%m%d %H:%M') for i in range(hourly.shape[0])]
        temp = pd.DataFrame({'date': date, 'temp': hourly['temp']})
        ans[locs[files.index(f)]] = temp

# if one is shorter, cut the others
nrows = list(map(lambda x: ans[x].shape[0], locs))
max_n = min(nrows)
if (not all([nrows[i] == max_n for i in range(len(nrows))])):
    for x in ans.keys():
        ans[x] = ans[x][0:max_n]

df = pd.DataFrame({'date': ans['Prato']['date'],
                  'Prato': ans['Prato']['temp'],
                  'Aarhus': ans['Aarhus']['temp'],
                  'Leipzig': ans['Leipzig']['temp'],
                  'Stara': ans['Stara']['temp']})
df['date'] = [datetime.strptime(df['date'][i], '%Y-%m%d %H:%M') for i in range(len(df['date']))]

# plot and save to pdf
fig, ax = plt.subplots(1, 1, figsize=(10, 5))
ax.set_facecolor("#000000") 
plt.grid(color = 'grey', linestyle = '--', linewidth = 0.5)
palette = plt.get_cmap('Set2')
num = 0
for column in df.drop('date', axis = 1):
    num += 1
    plt.plot(df['date'], df[column], marker = '', color = palette(num), linewidth = 2, alpha = 1, label = column)

plt.legend(loc = 1, ncol = 1)
plt.xlabel("Time")
plt.ylabel("Temperature")
xformatter = mdates.DateFormatter('%H:%M')
plt.gcf().axes[0].xaxis.set_major_formatter(xformatter)
plt.tick_params(axis = 'x', rotation = 90)
ax.set_xticks(df['date'][::3])
ax.xaxis.label.set_color('#999999')
ax.yaxis.label.set_color('#999999')
ax.tick_params(axis = 'x', colors = '#999999')
ax.tick_params(axis = 'y', colors = '#999999')
ax.spines['left'].set_color('#999999')
ax.spines['bottom'].set_color('#999999')
ax.spines['right'].set_color('#999999')
ax.spines['top'].set_color('#999999')
plt.savefig("plot.pdf", format = "pdf", facecolor = "black", bbox_inches = 'tight')
