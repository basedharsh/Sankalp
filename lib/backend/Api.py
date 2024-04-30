import os
from flask import Flask, jsonify, request
import requests
from pyresparser import ResumeParser



# cred = admin.credentials.Certificate("lib/resources/api/vanrakshak-1db86-firebase-adminsdk-thgz2-58a898d20b.json")
# default_app = admin.initialize_app(
#     cred,
#     {'databaseURL': "https://vanrakshak-1db86-default-rtdb.asia-southeast1.firebasedatabase.app/",
#      'storageBucket': "vanrakshak-1db86.appspot.com"}
# )

app = Flask(__name__)


@app.route('/profileGenerate',methods=['GET'])
def satelliteImageScript():
    output = {}
    username = str(request.args['username'])
    uid = str(request.args['userid'])
    resumelink = str(request.args['resumelink'])
    url = f"https://api.github.com/users/{username}"

    try:
        response = requests.get(url)
        response.raise_for_status()
        data = response.json()

        # print("User Details 1 :",data)
        output["profilePicture"] = data.get('avatar_url', 'N/A')
        output["name"] = data.get('name', 'N/A')
        output["bio"] = data.get('bio', 'N/A')
        output["followers"] = data.get('followers', 0)
        output["location"] = data.get('location', 'N/A')
        output["publicRepos"] = data.get('public_repos', 0)
        output["companyName"] = data.get('company', 'N/A')
        output["githubLink"] = data.get('html_url', 'N/A')
        # print(f"Name: {data.get('name', 'N/A')}")
        # print(f"Bio: {data.get('bio', 'N/A')}")
        # print(f"Followers: {data.get('followers', 0)} Followers")
        # print(f"Following: {data.get('following', 0)} Following")
        # print("Profile:")
        # print(f"Avatar URL: {data.get('avatar_url', 'N/A')}")

        try:
            response = requests.get(data.get('repos_url', 'N/A'))
            response.raise_for_status() 
            data = response.json()

            repoList = []   
            # print("User Details 2 :",data[0])
            if data._len_() <= 10:
                for i in range(0,data._len_()):
                    repoDetails = {} 
                    repoDetails["name"] = data[i].get('name', 'N/A')
                    repoDetails["description"] = data[i].get('description', 'N/A')
                    repoDetails["repoUrl"] = data[i].get('html_url', 'N/A')
                    repoDetails["created_at"] = data[i].get('created_at', 'N/A')
                    repoList.append(repoDetails)
            else:
                for i in range(0,10):
                    repoDetails = {} 
                    repoDetails["name"] = data[i].get('name', 'N/A')
                    repoDetails["description"] = data[i].get('description', 'N/A')
                    repoDetails["repoUrl"] = data[i].get('html_url', 'N/A')
                    repoDetails["created_at"] = data[i].get('created_at', 'N/A')
                    repoList.append(repoDetails)

            output["repoDetails"] = repoList

        except requests.exceptions.HTTPError as err:
            print(f"HTTP Error: {err}")
        except requests.exceptions.RequestException as err:
            print(f"Request Exception: {err}")

    except requests.exceptions.HTTPError as err:
        print(f"HTTP Error: {err}")
    except requests.exceptions.RequestException as err:
        print(f"Request Exception: {err}")

    print(resumelink)
    response = requests.get(resumelink)
    with open(uid +'.pdf', 'wb') as f:
        f.write(response.content)

    resumeData = ResumeParser(os.getcwd().replace("\\", "/")+"/"+uid+".pdf").get_extracted_data()
    print(resumeData)
    output["resumeData"] = resumeData
    return jsonify(output)

#########################################################################################################################################################################################


if __name__ == '__main__':
    app.run()